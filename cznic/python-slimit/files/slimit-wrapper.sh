#!/bin/sh
export PYTHONPATH="$PYTHONPATH"
python -c "from slimit.minifier import main; main()" $@
