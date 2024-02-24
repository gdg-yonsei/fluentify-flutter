<h1 align="center"><img src="https://github.com/gdsc-ys/fluentify-flutter/assets/11978494/8755bc8b-1ee0-4b49-bc98-0d4d930916bb" alt="icon" width="25" height="25"> fleuntify - Flutter</h1>

![cover-v4](https://github.com/gdsc-ys/fluentify-flutter/assets/11978494/1afba24e-064a-43d2-9ffd-92596b26a820)

## Overview
*fluentify* is our submission to Google Solution Challenge 2024, a solution addressing the communication hurdles experienced by children with hearing impairments. By providing personalized feedback to their speech, it aims to empower confidence in communication and promote inclusivity in society.

This is the repository for the client application. You can check out our other components such as [fluentify - Server](https://github.com/gdsc-ys/fluentify-server) and [fluentify - IDL](https://github.com/gdsc-ys/fluentify-idl).

## Flows

### 1. Select topic and feedback type
| Home | Topic selection | Feedback selection |
|:-:|:-:|:-:|
| ![home](https://github.com/gdsc-ys/fluentify-flutter/assets/11978494/64d83f3a-e47c-4973-adb9-98f0e675bb9b) | ![select-topic](https://github.com/gdsc-ys/fluentify-flutter/assets/11978494/5e779e9a-0294-47b2-9469-a928d49e8cc1) | ![select-feedback](https://github.com/gdsc-ys/fluentify-flutter/assets/11978494/1362ee78-6509-472e-b8bd-e8766ebc5d49) |

### 2. Record speech and get a feedback
| Pronunciation feedback | Communication feedback |
|:-:|:-:|
| <video src="https://github.com/gdsc-ys/fluentify-flutter/assets/11978494/abfa7efb-89c7-47ff-b104-0f6082c8326a"> | <video src="https://github.com/gdsc-ys/fluentify-flutter/assets/11978494/ae40d0bc-68ee-4b78-8bfe-40354c75fc29"> |

## How to start

You can download the released version of our application from [here](https://github.com/gdsc-ys/fluentify-flutter/tree/main/release).

## How to sync interfaces

### 1. Clone this project recursively.
```sh
git clone --recursive https://github.com/gdsc-ys/fluentify-flutter.git
```

### 2. Generate required interfaces from proto
```sh
brew install bufbuild/buf/buf
sh scripts/sync_idl.sh
```
