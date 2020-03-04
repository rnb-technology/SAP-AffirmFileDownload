# This is the FTP command file that's called by affirm.sh
# Once connected to the remote SFTP server, change both local and remote directories
cd reports
lcd /interfaces/PRD/inbound/AFFIRM/
# Download the file
get Room*.csv
# All done, so quit
bye
