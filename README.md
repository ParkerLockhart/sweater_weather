# Sweater Weather

Sweater weather is an app that allows users to plan ahead for road trips. Users can enter their origin and destination locations and receive information about the travel time, current weather, and forecasted weather upon estimated time of arrival at their destination. This project is created using a service-oriented architecture, so this repository contains only the backend of the app.

Skip to section: 
<details>
  <summary> Installation </summary>
  
  - [Clone repo](#clone-the-repository)
  - [Ruby version](#check-your-ruby-version)
  - [Dependencies](#install-dependencies)
  - [External APIs/environment config](#obtain-external-api-keys-and-set-environment-variables)
  - [How to run the test suite](#to-run-the-test-suite)
  - [Start local server](#start-local-server)
</details>

<details>
  <summary> Endpoints </summary>
  
  - [GET forecast](#forecast)
  - [GET background](#background-image)
  - [POST users](#user-registration)
</details>




## Installation

### Clone the repository 
``` 
git clone git@github.com:ParkerLockhart/sweater_weather.git
cd sweater_weather
```

### Check your ruby version
```
ruby -v
```
This repo uses `ruby 2.7.2`  so if needed, install the correct version using [rbenv](https://github.com/rbenv/rbenv):

```
rbenv install 2.7.2
```

### Install dependencies
 
 Using [bundler](https://bundler.io/):
 ```
bundle install
```

### Initialize the database 
```
rails db:create db:migrate
```

### Obtain external api keys and set environment variables

You will need to sign up to obtain your own api keys for: 
- [MapQuest](https://developer.mapquest.com/documentation/)
- [OpenWeather](https://openweathermap.org/api)
- [Unsplash](https://unsplash.com/developers)

Set them as environment variables using [figaro](https://github.com/laserlemon/figaro):
```
bundle exec figaro install
```
See the Figaro README for examples of how to configure your config/application.yml file with your api keys.

### To run the test suite:

```
rspec 
```

### Start local server 
```
rails s
```

## Endpoints 

### Forecast

GET http://localhost:3000/api/v1/forecast

Contains current weather, 5 day forecast, and 8 hour weather details. 

Parameters: 
 | param | data type | value | required/optional |
 |---|---|---|---|
 | location | string | city, state/country (ex. location=Denver,CO or location=London,UK) | REQUIRED |

Example response:

<details>
  <summary> 200 OK </summary>

```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2022-03-08 18:27 -0600",
                "sunrise": "2022-03-08 06:51 -0600",
                "sunset": "2022-03-08 18:37 -0600",
                "temperature": 56.89,
                "feels_like": 54.45,
                "humidity": 46,
                "uvi": 0,
                "visibility": 10000,
                "conditions": "clear sky",
                "icon": "01d"
            },
            "daily_weather": [
                {
                    "date": "2022-03-08",
                    "sunrise": "2022-03-08 12:00 -0600",
                    "sunset": "2022-03-08 12:00 -0600",
                    "max_temp": 57.76,
                    "min_temp": 44.29,
                    "conditions": "light rain",
                    "icon": "10d"
                },
                {
                    "date": "2022-03-09",
                    "sunrise": "2022-03-09 12:00 -0600",
                    "sunset": "2022-03-09 12:00 -0600",
                    "max_temp": 65.1,
                    "min_temp": 40.03,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "date": "2022-03-10",
                    "sunrise": "2022-03-10 12:00 -0600",
                    "sunset": "2022-03-10 12:00 -0600",
                    "max_temp": 73.9,
                    "min_temp": 43.09,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2022-03-11",
                    "sunrise": "2022-03-11 12:00 -0600",
                    "sunset": "2022-03-11 12:00 -0600",
                    "max_temp": 58.05,
                    "min_temp": 38.26,
                    "conditions": "moderate rain",
                    "icon": "10d"
                },
                {
                    "date": "2022-03-12",
                    "sunrise": "2022-03-12 12:00 -0600",
                    "sunset": "2022-03-12 12:00 -0600",
                    "max_temp": 57.52,
                    "min_temp": 31.57,
                    "conditions": "clear sky",
                    "icon": "01d"
                }
            ],
            "hourly_weather": [
                {
                    "time": "18:00 -0600",
                    "temperature": 56.89,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "time": "19:00 -0600",
                    "temperature": 55.98,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "20:00 -0600",
                    "temperature": 53.76,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "21:00 -0600",
                    "temperature": 50.76,
                    "conditions": "few clouds",
                    "icon": "02n"
                },
                {
                    "time": "22:00 -0600",
                    "temperature": 47.66,
                    "conditions": "scattered clouds",
                    "icon": "03n"
                },
                {
                    "time": "23:00 -0600",
                    "temperature": 44.29,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "00:00 -0600",
                    "temperature": 42.58,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "01:00 -0600",
                    "temperature": 41.79,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                }
            ]
        }
    }
}
```
</details>

### Background image

GET http://localhost:3000/api/v1/backgrounds

Sends a random photo from [Unsplash.com](https://unsplash.com/) related to the location provided. 

Parameters: 
 | param | data type | value | required/optional |
 |---|---|---|---|
 | location | string | city, state/country (ex. location=Denver,CO or location=London,UK) | REQUIRED |

Example response: 

<details>
  <summary> 200 OK </summary>

```
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "location": "san antonio,tx",
            "image_url": "https://images.unsplash.com/photo-1591648279732-4ce0c451ace3?ixid=MnwzMDc2NDR8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NDY3ODU4MTY&ixlib=rb-1.2.1",
            "credit": {
                "source": "https://unsplash.com",
                "author": "Henry Becerra"
            }
        }
    }
}
```
</details>

### User Registration

POST http://localhost:3000/api/v1/users

Creates a user in the database and generates an api_key.

Body parameters:
 | param | data type | value | required/optional |
 |---|---|---|---|
 | email | string | user@email.com (must be unique) | REQUIRED |
 | password | string | password | REQUIRED |
 | password_confirmation | string | must be the exact same value as password | REQUIRED |

<details>
  <summary>Example request body</summary> :
  
  ```
  {
    "email": "jessica@email.com",
    "password": "password123",
    "password_confirmation":"password123"
  }
```
</details> 

Example response: 

<details>
  <summary> 200 OK </summary>

  ```
  {
    "data": {
        "id": "3",
        "type": "user",
        "attributes": {
            "email": "jessica@email.com",
            "api_key": "XGmPkpPzXo53x2qCMVMRwqAtH"
        }
    }
}
```
</details>
<details>
  <summary> 422 Unprocessable Entity </summary>
  ```
    {
    "error": "Passwords don't match."
    }
  ```
or 
```
  {
    "error": "{:email=>["has already been taken"]}"
  }
```
</details>



 



