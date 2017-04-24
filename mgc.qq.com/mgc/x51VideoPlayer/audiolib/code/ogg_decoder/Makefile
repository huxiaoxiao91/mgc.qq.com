T05: check
	 "$(FLASCC)/usr/bin/g++" $(BASE_CFLAGS) -O4 ogg_decoder.cpp as3api.cpp main.cpp -I./include -L./lib -lvorbis -logg -emit-swc=h3d.x51.web.ogg_decoder -o ogg_decoder.swc
	"$(FLEX)/bin/mxmlc" -static-link-runtime-shared-libraries -compiler.omit-trace-statements=false -library-path=ogg_decoder.swc -debug=false swcdemo.as -o swcdemo.swf

include ../Makefile.common

clean:
	rm -f *.swf *.swc *.bc *.exe
