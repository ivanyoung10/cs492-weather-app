# Deployment Instructions 
Step 1: Fork the Repository

    Go to the main repository URL:
    https://github.com/ivanyoung10/cs492-weather-app.git

    In the top-right corner, click the Fork button to create a copy of the repository under your own GitHub account.
        This will create a forked version of the repository that you can modify without affecting the original repository.

Step 3: Clone Your Fork to Your Local Machine

    Navigate to a directory on your local machine where you want to store the repository. You can use the terminal to move to that directory. For example:

    cd ~/Documents/Projects

    Clone the repository

git clone https://github.com/YOUR_USERNAME/cs492-weather-app.git  

replace with your own user name

    Navigate to the new repository

 cd cs492-weather-app


Be sure you select a device by clicking in the lower right corner of VSCode where it may say "No Device" to drop down available devices, and choose the android/iphone device that you set up.

Install dependencies:

   flutter pub get

Run flutter:

  flutter run


# CS492 Final Project: Weather App

This application retrieves weather information from an external api and shows the information in a standard format, similar to most modern weather apps

## Features of the application inlcude 
* Accurate weather for day and night for the week, including a detailed forecast about that day's weather
* Color Picker for app
* Light and dark mode settings
* Ability to pick a location by name or gps
* Last used locations get saved to shared_prefences
