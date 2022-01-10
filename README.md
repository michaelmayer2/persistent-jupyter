# Persistent Jupyter Sessions - PoC 

## Introduction

Jupyter as such heavily interacts with the user`s browser environment. There is users that tend to use jupyter for their interactive computing needs whereby "interactive" also sometimes includes longer running computations. If the user disconnects from a running jupyter however the calculation is stopped. 

The solution presented here is to use [xpra](https://xpra.org) as a virtual frame buffer where we run a browser (Google Chrome) hidden to the end user. The connection to this xpra hosted browser (running in kiosk mode) is made via xpra`s html5 interface using websockets. 

One further design idea here is that the browser used must not interfere with users` home directories. Hence in the container all `XDG_*` environment variable are redirected to /tmp/mm.  

`google-chrome` is challenging to get to startup outside of existing configuration files without interactively telling you that this is the firt time `google-chrome` runs and asks you to click on `OK`. Even if configuration files are supplied it complains about locks. Hence we have chosen to run `google-chrome` once in the container, then remove all the files named `LOCK`, `Local State`, `SingletonCookie`, `SingletonSecret` and `SingletonLock` and put everything in `mm.tgz`.

## Building the container 

```bash
bash docker-build.sh
```

## Running the container 

```bash
docker-compose up -d 
```

## Connecting to jupyter 

Browse to [https://localhost:10000](https://localhost:10000) and see jupyter running. 

## Known issues 

- Authentication to the xpra sessions is currently disabled but can be easily configured. Token-based authentication for jupyter is "hidden behind" the xpra/google-chrome to jupyter connection. 
- Keyboard mapping can be challenging - xpra uses the language setting in your browser to infer the keyboard settings
- Resolution is adapting to network bandwidth - if frequent changes happen in the UI, resolution will temporarily degrade slightly but sharpen up immediately when changes are less frequent.  
