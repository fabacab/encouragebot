# Encouragebot - README

Hello! You are wonderful! You can do great things! I am here to remind you of these facts. :)

I was written by maymay as a gift to someone they love very much, but I am also available for anyone else to use. Right now, I can only live inside of Mac OS X computers that also have the `shuf` utility available. But don't worry, it's very easy to install `shuf` if you don't already have it.

## Installing

Let me explain how to make your Mac a place where I can live.

1. First, you need to get `shuf`. The `shuf` utility is available as part of the GNU `coreutils` package. You can install the GNU `coreutils` package via the [MacPorts](https://macports.org/) or [Homebrew](http://brew.sh) package managers. If you don't already have one of those, install it.
    * If you chose to install MacPorts, open a Terminal window and type `sudo port install coreutils` into it. Then press `return`.
    * If you chose to install HomeBrew, open a Terminal window and type `brew install coreutils` into it. Then press `return`.
1. Next, download the youngest (newest) version of me from the [Releases](https://github.com/meitar/encouragebot/releases) page on this GitHub repository. (You can also [try out my latest version](https://github.com/meitar/encouragebot/archive/master.zip) before I had a lot of practice and testing.)
1. I'm currently a set of three files: a program file, named `encouragebot.sh`, a [launchd](http://launchd.info/) job file, named `net.maymay.encouragebot.plist`, and a database of encouraging phrases, named `encouragements.txt`.
    * Please put my program file into *your home folder's* Applications folder (`~/Applications`). If this folder doesn't aready exist, just make a new folder inside your Home folder and call it `Applications`. Then put me in there. :)
    * Please put my launchd job file in your `~/Library/LaunchAgents` folder. (This job file is only needed if you want me to periodically remind you how wonderful you are on my own, without you asking me for encouragement yourself.)
    * If you want to be encouraged with some generic feel-good phrases, please put my database of encouraging phrases (`encouragements.txt`) into your `~/Library/Application Support/encouragebot` folder. (Again, you may need to make the `encouragebot` folder if it doesn't already exist.)

That's all. :) I'm now ready to encourage you whenever you need me to!

## Using

You can give me instructions about how you would like me to encourage you. Please do give me some instructions so that I can be the best encouragement bot for you that I can be! Don't feel shy, you're not being "bossy." You're asking for what you need!

Use the `--create` command to tell me about a phrase that you feel encourages you:

    ./encouragebot.sh --create 'You can do the thing!'

I'll remember the phrase you told me. Later, I will remind you that "you can do the thing!" :)

You can `--create` as many phrases as you want me to remember, one per line:

    ./encouragebot.sh --create 'Great shot, kid! That was one in a million!'
    ./encouragebot.sh --create 'You have my axe.'

If you get tired of hearing a specific encouraging phrase, you can tell me not to say it again by `--delete`ing it. Please be specific, since punctuation and capitalization look like different phrases to me. That means this will work:

    ./encouragebot.sh --delete 'You have my axe.'

But this will not work:

    ./encouragebot.sh --delete 'you have my axe'

To have me remind you what phrases you've told me to use to encourage you with, use the `--list` command:

    ./encouragebot.sh --list

I'll show you all the encouraging phrases that I'm currently remembering for you:

    maymay$ ./encouragebot.sh --list
    You can do the thing!
    Great shot, kid! That was one in a million!
    You have my axe.
    maymay$ 

If you only remember a little bit of a phrase but want to see how I remember it, you can type a partial phrase after the `--list` switch:

    maymay$ ./encouragebot.sh --list million
    Great shot, kid! That was one in a million!
    maymay$ 

You can also get more detailed information about what kinds of instructions I understand by asking me for `--help` directly:

    ./encouragebot.sh --help

This will print out a usage summary and explain what all the commands I respond to look like, and what they do.

# More about encouragebot

Encouragebot is a little love code in a packet sent across the Internet. It was written by [maymay](http://maymay.net/) during an evening of self-care. No rights reserved. For what is love if not freedom from ownership?
