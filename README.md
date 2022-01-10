# SFTP

These are scripts I made to run on a Debian SFTP server. I learned how to secure an Internet exposed device using SELinux and SFTP specific permissions. 

`sftpgen.sh` - Ran the user through a wizard to create a user, set an expiration date 2 weeks in advance, created the UP and DOWN directories with proper permissions, and provides the credentials for the user.

`upload_noti.sh` - Sends email notifications when writing operations end to an email of your choice using MSMTP. Includes the name of the file that was uploaded and user that uploaded the file in email.

`rem_expired.sh` - Deletes expired accounts and its home directory. Logs actions to file. Only run when you are ready to delete the expired accounts. Recommend running once every month.
