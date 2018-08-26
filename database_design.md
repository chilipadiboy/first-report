# Database and file server design

## Authentication
The authentication database will contain the following:


1.  emails
2.  passwords with a unique salt
3.  secondary contact(phone/randomly generated passphrase) for a second factor of authentication
4.  type of account
5.  Personal information
 
This data base will be used for logging in and out of the application as well as a reference to applying permissions to files, folders and readings.

The primary key will the email while type can be determined by a boolean function to ensure that a person can be all types of people involved (doctor, patient, researcher).

## User template
Each user has their own account in the authentication server as well as their own unique url which links to their personal webpage. This webpage will have links to files belonging to them.

Each individual file will have a list of users which are allowed to have access to said file. Users which have no access to a particular file will be able to see the file but not have access to it. All categories however will be visible.

## Permissions
Permissions to file access and database information are based of a list of users and are based off CRUD (Create, Read, Update, Delete) rules. By default, the owner of the files will be the actual user and permissions can be assigned according to specific needs.

Other users can request for permissions if needed.

## Anonymizing and data retrieval
A special database for research data will hold anonymized data. Each category will have its own database with specific columns that can be filled in by the uploader or programmatically. The data will not contain any names or unique identifying information. 

A form will be used to retrieve data using prepared statements. This is because we will be dealing mainly with parameter inputs for this segment. It also provides less overhead in terms of building a query.

## Security
### Server and database
The server root access will be removed and instead a special Database administrator account will have admin access to the server.

All databases will set up according to CIS guidelines for best practices. The servers hosting them will be following this guidelines as well.

### Authentication system
Our system will employ a 2 factor authentication system with a recovery process. It will involve a username and password *and another secondary authentication*

### File Server
All files will be scanned with an antivirus scanner before upload. Attempting to upload an unsafe file will result in an account getting locked

### Interaction
All input information will be escaped to prevent any sql and cross side scripting attacks. Executables will not be allowed for upload as they are not required for our purposes.