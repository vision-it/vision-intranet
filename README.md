# vision-intranet

[![Build Status](https://travis-ci.org/vision-it/vision-intranet.svg?branch=production)](https://travis-ci.org/vision-it/vision-intranet)

## Parameter


## Usage

Include in the *Puppetfile*:

```
mod vision_intranet:
    :git => 'https://github.com/vision-it/vision-intranet.git,
    :ref => 'production'
```

Include in a role/profile:

```puppet
contain ::vision_intranet
```

