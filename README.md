# QNAP-QTS-Tools

***A compilation of Linux tools for [QNAP](https://www.qnap.comhttps:/) NAS Running QTS***\*\*

This is still work in progress, but it seems very useful so I thought I would share it.

\*\*It should work with [QTS4.5.2](https://www.qnap.com/qts/4.5.2/en-us/https:/) to [QTS5.0.0](https://www.qnap.com/qts/5.0.0/en-us/) but I've only ever tested it with my TS-451+ and I have no idea if it works with anything else.

**Current working package list:**

- ```git```
- GNU compiler collection (```gcc``` compiler, bintools, etc)
- ```fdupes```
- GNU ```make```
- libncurses
- libpcre
- Python 3.7
- util-linux (I needed ```flock```)
- \+\+ All libaries the above require

**In testing:**

* veracrypt
* VSCode/remote

Next on the list:

* TBD

## Short story

I wanted to consolidate years of backups and copies of my
data located on several external and removable drives into
my new huge QNAP NAS.

Only to find there was no build in app to deduplicate the files.

I imagined I could just apt install whatever I liked but, though that is possible using Linux Station and/or Container Station, you can't do it for any app as QTS is based on a very cut down Linux and
has none of the usual tools or libraries installed.

**Spolier:** What started as a desire to just install one tool turned into a generic way to start building anything I like!!

It all started when I found this:
**[Michael's Blog: Install Git on QNAP QTS](https://sdhuang32.github.io/install-git-on-qts)**

Only it's *very* out of date.  And then there is the problem that [Centos 7 is dead](https://www.theregister.com/2021/01/26/killing_centos/).

First I needed git so I could get the sources I need and thus be able to work remotely in a decent IDE (VS Code).

After fixing the Centos 7 Docker based build environemnt I was able to start building some tools including fdupes (which is what I wanted in the first place)

## Installation

1. WIP....  Still working on making this seamless and publishing the Docker image behind it
2. TODO
3. ....

### Basic process - build / install

* Allow shell access to the QNAP NAS
* Use system-docker to get the first image sourced and built
* Use the makefile to build further modules (once you have git and gcc the rest get easier)
* Install the resulting program in a non-volatile place (I use /share/Public/[bin, lib, etc])
* Update the path for the users (note don't do this using /etc as QNAP will just undo it)
* Run sudo ldconfig if you have built any shared libraries

The new tools are instlled in a completely separate folder tree from the QTS operating system. That way it's almost impossible to brick or damage your NAS. As you are installing as a non-provelaged user you *should not* be able to overwrite anything important.

Saying that, I am sure somebody will - for which myself or others involved in this project take no responsibility - ! __YOU HAVE BEEN WARNED__ !

### Basic Process - porting

1. use ```bash``` inside the Docker image to get the sourcecode for the module you want to build, often that's just a git checkout but it could be SVN, wget, whatever.
2. Read up on the build process and make a note of any dependencies as you may have to build them first if they are not already present in QTS
3. Run the build process, and resolve any issues, make changes, defines, patches, etc as required.
4. Distil that knowledge into a build script that the Docker image will late use for automation.

## WARNING

**Only ever do this as a non-privelaged user
If you overwrite system files you will have a world of pain fixing it.\*\*

\*\* *The only changes you ever have to make as a privilaged user is to run ldconfig and update
the global user PATH*

## Known issues

I've found QNAP OS updates seem to kill of any user ```.bashrc``` type customisations.  Not too much of a problem but I will find a way round that some time.

## References

https://gibsonic.org/tools/2019/08/08/gcc_building.html
