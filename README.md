# All for one
## Proyecto Tecnología y Aplicaciones Web - IIC2513

#### Tema: Plataforma para crowdfounding

#### Integrantes:
* Arturo Bulnes
* Juan Ignacio Cortés

#### API's USED
* Vimeo: for videos url validation
* Twitter: for getting related tweets for projects

#### all-for-one
* For getting your own token for this app you must have an user and ask for it in your profile

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

#### Paperclip on development
Mac OS X
* brew install imagemagick
* brew install gs
Ubuntu (or any Debian base Linux distribution)
* sudo apt-get install imagemagick -y

### Default images
For projects:
* zelda.jpg

For users:
* default-avatar.png

#### Heroku
https://all-for-one.herokuapp.com/
