# vim: noet ts=8 sw=8 sts=8

MD		= .
LIBNX		= libnx.a
TEST		= cxx
Q		= @

CXXFLAGS	= -std=c++17

SRCDIR		= .

INCLUDE		= -I./include/nx -I./include

LIBNXSRC	= initializer_list.cc iostream.cc new.cc string.cc
LIBNXOBJ	= $(addsuffix .o,$(LIBNXSRC))

TESTSRC		= cxx.cc
TESTOBJ		= $(addsuffix .o,$(TESTSRC))

MAKEFILE	= Makefile

.PHONY: all clean

all: $(LIBNX) $(TEST)

$(MD)/%.cc.o: %.cc
	@mkdir -p $(MD)/$(dir $<)
	@echo "CXX" $(notdir $<)
	$(Q)$(CXX) -MD -MF $(MD)/$<.d $(INCLUDE) $(CXXFLAGS) -c $< -o $@

$(LIBNX): $(LIBNXOBJ)
	@echo "AR" $(notdir $(LIBNX))
	$(Q)ar rcs $(LIBNX) $(LIBNXOBJ)

$(TEST): $(LIBNX) $(TESTOBJ)
	@echo "LD" $(notdir $(TEST))
	$(Q)$(CXX) -o $(TEST) $(TESTOBJ) $(LIBNX)

clean:
	rm -f $(MD)/*.o
	rm -f $(INITFS)
	rm -f $(LIBNX)

