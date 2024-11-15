## Split EDI files into multiple files

I had to solve a an issue where EDI files would come in with multiple lines and it would break the SSIS package used to import these files so I decided to split them with this script.

# Setup

I configured this script in 2 parts.  The first part is to pull the files that contain more than one line in it into a seperate folder to so the second script can process and delete the multiple line file and create a new files one for each line.