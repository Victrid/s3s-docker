s3s-docker
=======================

The unofficial Docker image for [s3s](https://github.com/frozenpandaman/s3s).

This repository just keeps track of the original tool repository and builds an image to let it run as a containerized application.
Since this isn't the official tool repository so please go to the original if you want to read the document of the tool or send a bug-report or something.

This repository is derived from [issei-m/splatnet2statink-docker](https://github.com/issei-m/splatnet2statink-docker).

## How to use

If you have the `config.txt` file for s3s (or previous splatnet2statink for Splatoon 2), you can pass it via the variable `S3S_CONFIG`:

```
$ s3scfg=$(cat config.txt) && docker run -it --rm -e S3S_CONFIG=$s3scfg victrid/s3s:latest
```

Of course, some options for the command such as `-r` are available.

**If you don't have the configuration file, you can create it by the following steps:**

1. Hit this, it will start interacting you to create a new config file

```
$ docker run -it --name s3s-for-configuration --rm victrid/s3s:latest -t
```

2. Fill the values along questions the tool asked you
3. Once configuration finished, the tool will interact you again like this:

```
splatnet2statink v1.8.2
Pulling data from online...
Number of recent battles to upload (0-50)?
```

4. Open a new terminal tab and retrieve the configuration file from the container you started:

```
$ docker cp s3s-for-configuration:/opt/app/config.txt .
```

5. Back to the previous terminal, then you can now Ctrl-C to kill the container which is unnecessary anymore

## License

[GPLv3](https://choosealicense.com/licenses/gpl-3.0/) in according with the origin tool repository and docker repository it derived from.
