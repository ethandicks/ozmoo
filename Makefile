#DEBUGFLAGS = -DDEBUG=1
VMFLAGS = -DUSEVM=1
C1541 := /usr/bin/c1541
#X64 := /usr/bin/x64
X64 := /usr/bin/x64 -warp

#all: test
all: minform

d64.minform: 
	acme -DZ5=1 $(DEBUGFLAGS) $(VMFLAGS) --cpu 6510 --format cbm -l acme_labels.txt --outfile ozmoo ozmoo.asm
	cp minform/minform.d64 minform.d64
	$(C1541) -attach minform.d64 -write ozmoo ozmoo

d64.z3: 
	acme -DZ3=1 $(DEBUGFLAGS) $(VMFLAGS) --cpu 6510 --format cbm -l acme_labels.txt --outfile ozmoo ozmoo.asm
	cp d64toinf/dejavu.d64 dejavu.d64
	$(C1541) -attach dejavu.d64 -write ozmoo ozmoo

d64.z5:
	acme -DZ5=1 $(DEBUGFLAGS)  $(VMFLAGS) --cpu 6510 --format cbm -l acme_labels.txt --outfile ozmoo ozmoo.asm
	cp d64toinf/dragontroll.d64 dragontroll.d64
	$(C1541) -attach dragontroll.d64 -write ozmoo ozmoo

z3: d64.z3
	$(X64) dejavu.d64

z5: d64.z5
	$(X64) dragontroll.d64

minform: d64.minform
	$(X64) minform.d64

clean:
	rm -f ozmoo *.d64

