Archived from https://blog.aktsbot.in/no-more-blurry-fonts.html

# No more blurry fonts in linux

05 May 2023 

* * *

Ever since I saw [elementary os](https://elementary.io/) sporting the very legible [Inter](https://rsms.me/inter/) font for its UI and site, I wanted to make it part of my desktop too. The only problem was any font I'd choose got a little blurry. Not any more!

Open up `/etc/environment` and then add the following line to the end of it.

```
FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"
```

This enables [stem-darkening](https://freetype.org/freetype2/docs/hinting/text-rendering-general.html) for all fonts. This just makes fonts a little bit bolder on smaller screens. This makes a heck of a difference for Inter.

Reboot your machine and enjoy beautiful fonts.

Here's a before

 [![](/img/stem-darkening-off-thumb.png)](/img/stem-darkening-off.png) 

And an after

 [![](/img/stem-darkening-on-thumb.png)](/img/stem-darkening-on.png) 

_Happy Hacking & have a great day!_

*   [mail](mailto:box.ashishk@gmail.com)
*   [root](/)
*   [feeds](rss.xml)
*   [license](http://www.wtfpl.net/)
