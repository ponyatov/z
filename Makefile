# \ <section:var>
MODULE       = $(notdir $(CURDIR))
OS           = $(shell uname -s)
# / <section:var>
# \ <section:dir>
CWD          = $(CURDIR)
TMP          = $(CWD)/tmp
# / <section:dir>
# \ <section:tool>
WGET         = wget -c
PY           = bin/python3
PIP          = bin/pip3
PEP          = bin/autopep8
PYT          = bin/pytest
# / <section:tool>
# \ <section:src>
S += $(MODULE).py
# / <section:src>
# \ <section:all>
.PHONY: web
web: $(PY) $(S)
	$^
.PHONY: test
test: $(PYT) test_$(S)
	$^
# / <section:all>
# \ <section:install>
.PHONY: install
install: $(OS)_install js
	$(MAKE) $(PIP)
	$(MAKE) update
.PHONY: update
update: $(OS)_update
	$(PIP) install -U    pip autopep8
	$(PIP) install -U -r requirements.txt
.PHONY: Linux_install Linux_update
Linux_install Linux_update:
	sudo apt update
	sudo apt install -u `cat apt.txt`

# \ <section:py>
$(PY) $(PIP):
	python3 -m venv .
# / <section:py>

# \ <section:js>
.PHONY: js
js: static/js/bootstrap.min.css static/js/bootstrap.dark.css \
	static/js/bootstrap.min.js static/js/jquery.min.js \
	static/js/html5shiv.min.js static/js/respond.min.js \
	static/js/socket.io.min.js static/js/peg.min.js

JQUERY_VER = 3.6.0
static/js/jquery.min.js:
	$(WGET) -O $@ https://cdnjs.cloudflare.com/ajax/libs/jquery/$(JQUERY_VER)/jquery.min.js

BOOTSTRAP_VER = 4.6.0
static/js/bootstrap.min.css: static/js/bootstrap.min.css.map
	$(WGET) -O $@ https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/$(BOOTSTRAP_VER)/css/bootstrap.min.css
static/js/bootstrap.min.css.map:
	$(WGET) -O $@ https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/$(BOOTSTRAP_VER)/css/bootstrap.min.css.map
static/js/bootstrap.dark.css:
	$(WGET) -O $@ https://bootswatch.com/4/darkly/bootstrap.min.css
static/js/bootstrap.min.js: static/js/bootstrap.min.js.map
	$(WGET) -O $@ https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/$(BOOTSTRAP_VER)/js/bootstrap.min.js
static/js/bootstrap.min.js.map:
	$(WGET) -O $@ https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/$(BOOTSTRAP_VER)/js/bootstrap.min.js.map

static/js/html5shiv.min.js:
	$(WGET) -O $@ https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js
static/js/respond.min.js:
	$(WGET) -O $@ https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js

SOCKETIO_VER = 3.1.2
static/js/socket.io.min.js: static/js/socket.io.min.js.map
	$(WGET) -O $@ https://cdnjs.cloudflare.com/ajax/libs/socket.io/$(SOCKETIO_VER)/socket.io.min.js
static/js/socket.io.min.js.map:
	$(WGET) -O $@ https://cdnjs.cloudflare.com/ajax/libs/socket.io/$(SOCKETIO_VER)/socket.io.min.js.map

PEGJS_VER = 0.10.0
static/js/peg.min.js:
	$(WGET) -O $@ https://github.com/pegjs/pegjs/releases/download/v$(PEGJS_VER)/peg-$(PEGJS_VER).min.js

# / <section:js>
# / <section:install>
