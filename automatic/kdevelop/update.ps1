﻿import-module au

$releases = 'https://www.kdevelop.org/download'

function global:au_GetLatest {
     $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	 $regex   = '\.exe$'
	 $url = $download_page.links | ? href -match $regex | select -First 2	 
	 $version = $url -split '-|.exe' | select -Last 1 -Skip 3
	 $version_release = $version -replace '[.]',''	 
     return @{ Version = $version ; VersionRelease = $version_release ; URL32 = $url.href[1] ; URL64 = $url.href[0] }
}

function global:au_SearchReplace {
    @{
	    "kdevelop.nuspec" = @{
			"<releaseNotes>https://www.kdevelop.org/news/kdevelop-(.*?)-released</releaseNotes>" = "<releaseNotes>https://www.kdevelop.org/news/kdevelop-$($Latest.VersionRelease)-released</releaseNotes>"
        }
    }
}

update