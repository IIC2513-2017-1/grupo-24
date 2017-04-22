# All for one

#### Database creation
* Open postgres and create a role:
 * CREATE ROLE all_4_one WITH CREATEDB LOGIN PASSWORD 'all4onepassword';
* Run the rake db:setup

#### Deployment
First, be sure you don't have migrations pending:
* rake db:migrate

Then, ensure you have installed all the gems required
* bundle install

Finally...
* rails server
