# Persistent Jupyter Sessions - PoC 

## Introduction

Jupyter as such hevily interacts with the user's browser environment. There is users that tend to use jupyter for their interactive computing needs whereby "interactive" also sometimes includes longer running computations. If the user disconnects from a running jupyter however the calculation is stopped. 

The solution presented here is to use [xpra](https://xpra.org) as a virtual framebuffer where we run a browser (Google Chrome) hidden to the end user. The connection to this xpra hosted browser (running in kiosk mode) is made via xpra's html5 interface using websockets. 

## Building the container 

```bash
docker build . -t xpra:latest
```

## Running the container 

```bash
docker run -p 10000:10000 xpra:latest -d 
```

## Connecting to jupyter 

Browse to [https://localhost:10000](https://localhost:10000) and see jupyter running. 

## Known issues 

- Keyboard mapping can be challenging - xpra uses the language setting in your browser to infer the keyboard settings
- Google Chrome is tricky to preven the "Welcome to Google Chrome" window popping up. You will need to move the window to the middle of your browser window and the click on ok to get access to the jupyter session.
- Resolution is adapting to network bandwidth - if frequent changes happen in the UI, resolution will degrade slightly but sharpen up immediately when changes are less frequent.  
