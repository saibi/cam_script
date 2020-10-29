#!/bin/sh
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/snap/bin                                                                        
unset LD_LIBRARY_PATH

gst-play-1.0 --videosink=kmssink $1

