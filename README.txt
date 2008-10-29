= purse

http://quirkey.rubyforge.org/purse

== DESCRIPTION:

A simple way of storing private/sensitive info and then sharing it with others using git

== SYNOPSIS:

Purse stores information in a two level folder system. The basic piece of stored information is a 'note'. 
A 'pocket' is a folder containing one to many notes. A *pocket* can be synced between mutlple users/computers 
using a remote git repository.

To configure for the first time:

	purse

and follow the handy on screen instructions.

To create a new pocket/note.

	purse pocketname notename

It will prompt you asking if you want to create the note.
Once you've edited in your favorite editor and saved, purse 
will use Blowfish to encrypt the note with the password you provide. 

Then you can display the note with:

	purse pocketname notename

or edit with:

	purse pocketname notename --edit

Each time it will ask you for the password you initially provided to encrypt it.

For more commands/info run:

	purse --help

== REQUIREMENTS:

purse requires a couple of gems, namely 
	highline -- for command line tools
	termios		
	crypt	 -- for encryption
	git		 -- for uh, git

== INSTALL:

	sudo gem install purse

then run
	
	purse

== LICENSE:

(The MIT License)

Copyright (c) 2008 Quirkey NYC, LLC

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.