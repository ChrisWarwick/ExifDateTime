#requires -Modules PowerShellGet


$ReleaseNotes =@'


ExifDateTime

Chris Warwick, @cjwarwickps, August 2013
This version: November 2015


The module contains two functions:

    Get-ExifDateTaken -Path <filepaths>

        Takes a file (fileinfo or string) or an array of these
        Gets the ExifDT value (EXIF Property 36867)

    Update-ExifDateTaken -Path <filepaths> -Offset <TimeSpan>

        Takes a file (fileinfo or string) or an array of these
        Modifies the ExifDT value (EXIF Property 36867) as specified


# Example: Rename files based on DateTaken value

gci *.jpg |
 Get-ExifDateTaken |
 Rename-Item -NewName {"Holiday Snap {0:MM-dd HH.mm.ss dddd} ({1}).jpg" -f $_.ExifDateTaken, (Split-Path (Split-Path $_) -Leaf)}

# Example: Correct DateTake value on a set of .jpg images by specifying a time offset

gci *.jpg|Update-ExifDateTaken -Offset '-0:07:10' -PassThru|ft Path, ExifDateTaken

# Example: Update DateTaken & Rename files based on Date

gci *.jpg |
 Update-ExifDateTaken -Offset '-0:07:10' -PassThru |
 Rename-Item -NewName {"Holiday Snap {0:MM-dd HH.mm.ss dddd} ({1}).jpg" -f $_.ExifDateTaken, (Split-Path (Split-Path $_) -Leaf)}


Script Help, Get-ExifDateTaken
-----------

<#
.Synopsis
   Gets the DateTaken EXIF property in an image file.
.Description
   This cmdlet reads the EXIF DateTaken property in an image and passes is down the pipeline
   attached to the PathInfo item of the image file.
.Parameter Path
   The image file or files to process.
.Example
   Get-ExifDateTaken img3.jpg
   Reads the img3.jpg file and returns the im3.jpg PathInfo item with the EXIF DateTaken attached
.Example
   Get-ExifDateTaken *3.jpg |ft path, exifdatetaken
   Output the EXIF DateTaken values for all matching files in the current folder
.Example
   gci *.jpeg,*.jpg|Get-ExifDateTaken 
   Read multiple files from the pipeline
.Example
   gci *.jpg|Get-ExifDateTaken|Rename-Item -NewName {"Holiday Snap {0:MM-dd HH.mm.ss}.jpg" -f $_.ExifDateTaken}
   Gets the EXIF DateTaken on multiple files and renames the files based on the time
.Outputs
   The scripcmdlet outputs FileInfo objects with an additional ExifDateTaken
   property that can be used for later processing.
.Functionality
   Gets the EXIF DateTaken image property on a specified image file.
#>


Script Help, Update-ExifDateTaken
-----------

<#
.Synopsis
   Changes the DateTaken EXIF property in an image file.
.Description
   This cmdlet updates the EXIF DateTaken property in an image by adding an offset to the 
   existing DateTaken value.  The offset (which must be able to be interpreted as a [TimeSpan] type)
   can be positive or negative - moving the DateTaken value to a later or earlier time, respectively.
   This can be useful (for example) to correct times where the camera clock was wrong for some reason - 
   perhaps because of timezones; or to synchronise photo times from different cameras.
.Parameter Path
   The image file or files to process.
.Parameter Offset
   The time offset by which the EXIF DateTaken value should be adjusted.
   Offset can be positive or negative and must be convertible to a [TimeSpan] type.
.Parameter PassThru
   Switch parameter, if specified the paths of the image files processed are written to the pipeline.
   The PathInfo objects are additionally decorated with the Old and New EXIF DateTaken values.
.Example
   Update-ExifDateTaken img3.jpg -Offset 0:10:0  -WhatIf
   Update the img3.jpg file, adding 10 minutes to the DateTaken property
.Example
   Update-ExifDateTaken *3.jpg -Offset -0:01:30 -Passthru|ft path, exifdatetaken
   Subtract 1 Minute 30 Seconds from the DateTaken value on all matching files in the current folder
.Example
   gci *.jpeg,*.jpg|Update-ExifDateTaken -Offset 0:05:00
   Update multiple files from the pipeline
.Example
   gci *.jpg|Update-ExifDateTaken -Offset 0:5:0 -PassThru|Rename-Item -NewName {"Holday Snap {0:MM-dd HH.mm.ss}.jpg" -f $_.ExifDateTaken}
   Updates the EXIF DateTaken on multiple files and renames the files based on the new time
.Outputs
   If -PassThru is specified, the scripcmdlet outputs FileInfo objects with additional ExifDateTaken
   and ExifOriginalDateTaken properties that can be used for later processing.
.Notes
   This scriptcmdlet will overwrite files without warning - take backups first...
.Functionality
   Modifies the EXIF DateTaken image property on a specified image file.
#>



Version History:
---------------
  
V1.0 (Current Version) November 2015
> Initial release to the PowerShell Gallery 

V0.1-0.9 
> Dev versions


Other Modules:
------------
See all my other PS Gallery modules: 

  Find-Module | Where Author -like 'Chris*Warwick'




'@

$Tags = @(
    'Exif'
    'DateTaken'
    'Date'
    'Image'
    'jpg'
    'photo'
    'DateTime'
    '36867'
    'PowerShell'
    'FileStream'
)


$PublishParams = @{
    Name            = 'ExifDateTime'
    NuGetApiKey     = 'XXXXRedactedXXXX'
    ReleaseNotes    = $ReleaseNotes
    Tags            = $Tags
    ProjectUri      = 'https://github.com/ChrisWarwick/ExifDateTime'
}



Publish-Module @PublishParams


# ...later

# Find-Module ExifDateTime
