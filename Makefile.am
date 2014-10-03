###############################################################################
## Makefile for English--French
###############################################################################

VERSION=0.0.1
LANG1=en
LANG1a=en_GB
LANG1b=en_US
LANG2=fr
PREFIX1=$(LANG1)-$(LANG2)
PREFIX2=$(LANG2)-$(LANG1)
PREFIX2b=$(LANG2)-$(LANG1b)

BASENAME=apertium-$(PREFIX1)

TARGETS_COMMON = $(PREFIX1).automorf.bin $(PREFIX2).automorf.bin \
		 $(PREFIX1).autolex.bin $(PREFIX2).autolex.bin \
		 $(PREFIX1).autobil.bin $(PREFIX2).autobil.bin \
		 $(PREFIX1).autogen.bin $(PREFIX2).autogen.bin \
		 $(PREFIX1).autopgen.bin $(PREFIX2).autopgen.bin \
                 $(PREFIX2b).autogen.bin \
                 $(PREFIX1).t1x.bin $(PREFIX1).t2x.bin $(PREFIX1).t3x.bin \
                 $(PREFIX2).t1x.bin $(PREFIX2).t2x.bin $(PREFIX2).t3x.bin

# This include defines goals for install-modes, .deps/.d and .mode files:
@ap_include@

###############################################################################
## Transducers, disambiguation rules, transfer
###############################################################################

#$(BASENAME).$(LANG1)-lextor.dix: $(BASENAME).$(PREFIX1).dix
#	apertium-validate-dictionary $(BASENAME).$(PREFIX1).dix
#	apertium-gen-lextormono rl $(BASENAME).$(PREFIX1).dix $@
#
#$(BASENAME).$(LANG2)-lextor.dix: $(BASENAME).$(PREFIX1).dix
#	apertium-validate-dictionary $(BASENAME).$(PREFIX1).dix
#	apertium-gen-lextormono lr $(BASENAME).$(PREFIX1).dix $@
#
#$(BASENAME).$(PREFIX1)-lextor.dix: $(BASENAME).$(PREFIX1).dix
#	apertium-validate-dictionary $(BASENAME).$(PREFIX1).dix
#	apertium-gen-lextorbil rl $(BASENAME).$(PREFIX1).dix $@
#
#$(BASENAME).$(PREFIX2)-lextor.dix: $(BASENAME).$(PREFIX1).dix
#	apertium-validate-dictionary $(BASENAME).$(PREFIX1).dix
#	apertium-gen-lextorbil lr $(BASENAME).$(PREFIX1).dix $@
#

.deps/principal.xsl: principal.xsl .deps/.d
	cp $< $@

.deps/$(LANG1).metadix: $(BASENAME).$(LANG1).metadix .deps/.d
	xsltproc --stringparam alt $(LANG1a) alt.xsl $(BASENAME).$(LANG1).metadix >$@

.deps/$(LANG1).dix: .deps/$(LANG1).metadix .deps/principal.xsl
	xsltproc buscaPar.xsl .deps/$(LANG1).metadix | uniq > $<.tmp && \
	xsltproc $<.tmp .deps/$(LANG1).metadix > $@ && rm $<.tmp

.deps/$(LANG1b).metadix: $(BASENAME).$(LANG1).metadix .deps/.d
	xsltproc --stringparam alt $(LANG1b) alt.xsl $(BASENAME).$(LANG1).metadix >$@

.deps/$(LANG1b).dix: .deps/$(LANG1b).metadix .deps/principal.xsl
	xsltproc buscaPar.xsl .deps/$(LANG1b).metadix | uniq > $<.tmp && \
	xsltproc $<.tmp .deps/$(LANG1b).metadix > $@ && rm $<.tmp

$(PREFIX1).automorf.bin: .deps/$(LANG1).dix
	apertium-validate-dictionary .deps/$(LANG1).dix
	apertium-validate-acx $(BASENAME).$(LANG1).acx
	lt-comp lr .deps/$(LANG1).dix $@ $(BASENAME).$(LANG1).acx

#$(PREFIX1).automorf.bin: $(BASENAME).$(LANG1).metadix $(BASENAME).$(LANG1).acx
#	@rm tmp1gen.xsl
#	apertium-validate-acx $(BASENAME).$(LANG1).acx
#	apertium-validate-dictionary $(BASENAME).$(LANG1).dixtmp1
#	lt-comp lr $(BASENAME).$(LANG1).dixtmp1 $@ $(BASENAME).$(LANG1).acx
##	@rm $(BASENAME).$(LANG1).dixtmp1

$(PREFIX1).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $(BASENAME).$(PREFIX1).dix
##NO TOCAR	apertium-gen-oldbil $(BASENAME).$(PREFIX1).dix tmp$(PREFIX1).autobil.dix
#	xsltproc translate-to-default-equivalent.xsl $(BASENAME).$(PREFIX1).dix >tmp$(PREFIX1).autobil.dix
#	lt-comp lr tmp$(PREFIX1).autobil.dix $@
	lt-comp lr $(BASENAME).$(PREFIX1).dix $@
#	rm tmp$(PREFIX1).autobil.dix

$(PREFIX1).autogen.bin: $(BASENAME).$(LANG2).metadix
	@xsltproc buscaPar.xsl $(BASENAME).$(LANG2).metadix | uniq > $@.xsl
	@xsltproc $@.xsl $(BASENAME).$(LANG2).metadix > $<.tmp 
	@rm $@.xsl
	apertium-validate-dictionary $<.tmp
	lt-comp rl $<.tmp $@

$(PREFIX1).autopgen.bin: $(BASENAME).post-$(LANG2).dix
	apertium-validate-dictionary $(BASENAME).post-$(LANG2).dix
	lt-comp lr $(BASENAME).post-$(LANG2).dix $@

$(PREFIX2).automorf.bin: $(BASENAME).$(LANG2).metadix $(BASENAME).$(LANG2).acx
	apertium-validate-acx $(BASENAME).$(LANG2).acx
	@xsltproc buscaPar.xsl $(BASENAME).$(LANG2).metadix | uniq > $@.xsl 	 
	@xsltproc $@.xsl $(BASENAME).$(LANG2).metadix > $<.tmp 
	@rm $@.xsl
	apertium-validate-dictionary $<.tmp
	lt-comp lr $<.tmp $@ $(BASENAME).$(LANG2).acx

$(PREFIX2).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $(BASENAME).$(PREFIX1).dix
##NO TOCAR	apertium-gen-oldbil $(BASENAME).$(PREFIX1).dix tmp$(PREFIX2).autobil.dix
#	xsltproc translate-to-default-equivalent.xsl $(BASENAME).$(PREFIX1).dix >tmp$(PREFIX2).autobil.dix
#	lt-comp rl tmp$(PREFIX2).autobil.dix $@
	lt-comp rl $(BASENAME).$(PREFIX1).dix $@
#	rm tmp$(PREFIX2).autobil.dix

$(PREFIX2).autogen.bin: .deps/$(LANG1).dix
	apertium-validate-dictionary .deps/$(LANG1).dix
	lt-comp rl .deps/$(LANG1).dix $@

$(PREFIX2b).autogen.bin: .deps/$(LANG1b).dix
	apertium-validate-dictionary .deps/$(LANG1b).dix
	lt-comp rl .deps/$(LANG1b).dix $@

#$(PREFIX2).autogen.bin: $(BASENAME).$(LANG1).metadix
#	@xsltproc buscaPar.xsl apertium-en-es.en.metadix | uniq > tmp2gen.xsl 	 
#	@xsltproc tmp2gen.xsl apertium-en-es.en.metadix >$(BASENAME).$(LANG1).dixtmp2
#	@rm tmp2gen.xsl
#	apertium-validate-dictionary $(BASENAME).$(LANG1).dixtmp2
#	lt-comp rl $(BASENAME).$(LANG1).dixtmp2 $@
#	@rm $(BASENAME).$(LANG1).dixtmp2
#	@rm $(BASENAME).$(LANG1).metadix
#	@rm $(BASENAME).$(LANG2).dix	
#	@rm $(BASENAME).$(LANG1)-$(LANG2).dix	

$(PREFIX2).autopgen.bin: $(BASENAME).post-$(LANG1).dix
	apertium-validate-dictionary $(BASENAME).post-$(LANG1).dix
	lt-comp lr $(BASENAME).post-$(LANG1).dix $@

$(PREFIX1).t1x.bin: $(BASENAME).$(PREFIX1).t1x
	apertium-validate-transfer $(BASENAME).$(PREFIX1).t1x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t1x $@

$(PREFIX1).t2x.bin: $(BASENAME).$(PREFIX1).t2x
	apertium-validate-interchunk $(BASENAME).$(PREFIX1).t2x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t2x $@

$(PREFIX1).t3x.bin: $(BASENAME).$(PREFIX1).t3x
	apertium-validate-postchunk $(BASENAME).$(PREFIX1).t3x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t3x $@

$(PREFIX2).t1x.bin: $(BASENAME).$(PREFIX2).t1x
	apertium-validate-transfer $(BASENAME).$(PREFIX2).t1x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t1x $@

$(PREFIX2).t2x.bin: $(BASENAME).$(PREFIX2).t2x
	apertium-validate-interchunk $(BASENAME).$(PREFIX2).t2x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t2x $@

$(PREFIX2).t3x.bin: $(BASENAME).$(PREFIX2).t3x
	apertium-validate-postchunk $(BASENAME).$(PREFIX2).t3x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t3x $@

$(PREFIX1).autolex.bin: $(BASENAME).$(PREFIX1).lrx
	lrx-comp $< $@

$(PREFIX2).autolex.bin: $(BASENAME).$(PREFIX2).lrx
	lrx-comp $< $@

###############################################################################
## Distribution
###############################################################################

EXTRA_DIST=$(BASENAME).post-$(LANG1).dix $(BASENAME).post-$(LANG2).dix \
	   $(BASENAME).$(LANG1).tsx \
	   $(BASENAME).$(LANG2).tsx \
	   $(PREFIX1).prob $(PREFIX2).prob \
	   buscaPar.xsl principal.xsl alt.xsl \
           translate-to-default-equivalent.xsl \
	   $(BASENAME).$(PREFIX1).t1x $(BASENAME).$(PREFIX1).t2x \
	   $(BASENAME).$(PREFIX1).t3x $(BASENAME).$(PREFIX2).t1x \
           $(BASENAME).$(PREFIX2).t2x $(BASENAME).$(PREFIX2).t3x \
           $(BASENAME).$(LANG1).acx $(BASENAME).$(LANG2).acx \
	   modes.xml

###############################################################################
## Installation
###############################################################################

apertium_en_frdir=$(prefix)/share/apertium/$(BASENAME)/

# Files which should be installed to $(prefix)/share/apertium/$(BASENAME)/:
apertium_en_fr_DATA=$(TARGETS_COMMON) \
	$(PREFIX1).prob $(PREFIX2).prob \
	$(BASENAME).$(PREFIX1).t1x \
	$(BASENAME).$(PREFIX1).t2x \
	$(BASENAME).$(PREFIX1).t3x \
	$(BASENAME).$(PREFIX2).t1x \
	$(BASENAME).$(PREFIX2).t2x \
	$(BASENAME).$(PREFIX2).t3x

# All modes are created by the same goal, listing several will just give problems with make -j2
noinst_DATA=modes/$(PREFIX1).mode

install-data-local: install-modes


###############################################################################
## Cleanup
###############################################################################

clean-dicts:
	touch $(BASENAME).$(LANG1).dixtmp1 $(BASENAME).$(LANG1).metadix  $(BASENAME).$(LANG2).dix $(BASENAME).$(PREFIX1).dix $(BASENAME).$(PREFIX1).dix
	rm $(BASENAME).$(LANG1).dixtmp1
	rm $(BASENAME).$(LANG1).metadix
	rm $(BASENAME).$(LANG2).dix
	rm $(BASENAME).$(PREFIX1).dix

CLEANFILES = $(TARGETS_COMMON) apertium-en-fr.fr.dixtmp1
clean-local: 
	-rm -rf .deps modes

###############################################################################
## Test
###############################################################################

test: all
	echo "" | apertium -d . en-fr | tee .test-mt
	@echo "Så hun ikke ordene?" > .test-ref
	@diff .test-ref .test-mt
	echo "Jeg har åler i min luftputebåt" | apertium -d . nob-nno | tee .test-mt
	@echo "Eg har ålar i luftputebåten min" > .test-ref
	@diff .test-ref .test-mt
