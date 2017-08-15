#!/bin/bash
tcset --device $1 --direction outgoing --rate $2
tcset --device $1 --direction incoming --rate $3
/bin/bash
