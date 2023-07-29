## goodprogrammermegabbq

In this application, you can create an event, invite friends to it, add comments and photos to the event.

Actually, this is what the working version looks like, feel free to test it) [goodprogrammermegabbq](http://goodprogrammermegabbq.fun)

As a platform for deployment VPS

```
ruby: 3.2.1

rails: 7.0.4.3

app language: russian
```

In this application I have used:
1. Authentication with gem pundit
2. Gem omniauth for authentication through GitHub and Vkontakte
3. ActiveStorage and bucket S3 for uploading photo
4. Subscribers receive emails with the help of Mailjet
5. Locations in events are displayed on Yandex maps
6. Styles from bootstrap
7. Resque for background jobs
8. Capistrano to deploy

The gem `dotenv-rails` is already included in the gem file, so all you have to do is create a file `.env` in the project root with the keys necessary for the application to work, and you need to get keys: for [Yandex map](https://yandex.ru/dev/maps/jsapi/doc/2.1/quick-start/index.html#get-api-key), [S3 basket](https://cloud.yandex.ru/), [Mailjet](https://www.mailjet.com/), OmniAuth - [here](https://github.com/settings/developers) and [here](https://dev.vk.com/)

Example file `.env`

```
ACCESS_KEY_ID=accesskeyid
SECRET_ACCESS_KEY=secretkey
API_YANDEX_MAP=apikey
MJ_API_KEY=key
MJ_SECRET_KEY=key
MJ_SENDER_ADRESS=youadress
```

Just copy the repository to your local machine and then using the console go to the project folder


```
app_folder_your_computer_console$ cd goodprogrammermegabbq

app_folder_your_computer_console$ bundle install

app_folder_your_computer_console$ rails db:migrate

app_folder_your_computer_console$ bin/dev
```

After that, the application is available on localhost:3000

