# QNAP-QTS-Tools
**A compilation of Linux tools for QNAP NAS Running QTS**

This is still work in progress, but it seems very useful so I thought I would share it.

#####Short story
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

Installation
WIP....

The new tools are instlled in a completely separate folder tree from the QTS operating system, that way it's almost impossible to brick your NAS (but I am sure somebody will - you have been warned)

WARNING:
Only ever do this as a non-privelaged user
If you overwrite system files you will have a world of pain fixing it.

The only changes you ever have to make as a privilaged user is to run ldconfig and update
the global user PATH





https://gibsonic.org/tools/2019/08/08/gcc_building.html