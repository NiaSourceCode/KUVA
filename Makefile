#/*******************************
# *
# * Kuva - Graph cut texturing
# * 
# * From:
# *      V.Kwatra, A.Sch�dl, I.Essa, G.Turk, A.Bobick, 
# *      Graphcut Textures: Image and Video Synthesis Using Graph Cuts
# *      http://www.cc.gatech.edu/cpl/projects/graphcuttextures/
# *
# * JP <jeanphilippe.aumasson@gmail.com>
# *
# * main.cpp
# *
# * 01/2006
# *
# *******************************/
#
#  Copyright Jean-Philippe Aumasson, 2005, 2006
#
#  Kuva is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA



CC     = g++
# 只编译obj
cC     = $(CC) -c
# -Wall: 编译后显示所有警告
# -ffast-math: 编译不必遵循浮点运算标准, 提高浮点运算速度
CFLAG  = -Wall -O3 -ffast-math -fstrict-aliasing -malign-double
# avoid warnings for B. & K. code
GFLAG  = -O3 -ffast-math -fstrict-aliasing -malign-double
LFLAG  = -I/usr/X11R6/include -lm -lpthread -lX11 -L/usr/X11R6/lib
DFLAG  = -g
BIN    = kuva
SPATH  = src
OPATH  = obj
BPATH  = bin
TRASH  = *~ *.bmp *.jpg *.png *.sha256 $(BPATH)/$(BIN) $(OPATH)/*.o $(OPATH)/*~ 

# $^: 依赖文件, 冒号之后的
# $@: 目标文件, 冒号之前的

all:		
		@if [ ! -d $(OPATH) ]; then mkdir $(OPATH); fi;
		@if [ ! -d $(BPATH) ]; then mkdir $(BPATH); fi;
		make $(BIN)

$(BIN):		main.o args.o  argsgraph.o graph.o maxflow.o
		# $(CC) $(LFLAG) $(OPATH)/main.o $(OPATH)/args.o $(OPATH)/argsgraph.o $(OPATH)/graph.o $(OPATH)/maxflow.o -o $@
		$(CC) -o $(BPATH)/$@ $(OPATH)/main.o $(OPATH)/args.o $(OPATH)/argsgraph.o $(OPATH)/graph.o $(OPATH)/maxflow.o $(LFLAG)

main.o:		$(SPATH)/main.cpp
		$(cC) $(CFLAG) $^ -o $(OPATH)/$@

args.o:		$(SPATH)/args.cpp
		$(cC) $(CFLAG) $^ -o $(OPATH)/$@

argsgraph.o:	$(SPATH)/argsgraph.cpp
		$(cC) $(CFLAG) $^ -o $(OPATH)/$@

graph.o:	$(SPATH)/graph.cpp
		$(cC) $(GFLAG) $^ -o $(OPATH)/$@

maxflow.o:	$(SPATH)/maxflow.cpp
		$(cC) $(GFLAG) $^ -o $(OPATH)/$@

clean:
		rm -f $(TRASH)
