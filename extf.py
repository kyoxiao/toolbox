#!/usr/bin/env python
import sys
from prettytable import PrettyTable,HEADER,NONE,FRAME

DELIMITER=';'

disp = PrettyTable()
#disp.border = False
disp.hrules = HEADER
disp.vrules = NONE
input_tags = list()
col_names = list()

tag2name = dict()
tag2name = {
  '1'     : 'Account' ,
  '6'     : 'AvgPx',
  '31'    : 'LastPx',
  '32'    : 'LastShares',
  '35'    : 'MsgType',
  '38'    : 'OrderQty',
  '39'    : 'OrdStatus',
  '40'    : 'OrdType',
  '44'    : 'Price',
  '47'    : 'Rule80A',
  '49'    : 'SenderCompID',
  '50'    : 'SenderSubID',
  '52'    : 'SendingTime',
  '60'    : 'TransactTime'
}

def parseFIXMsg(msg):
  if msg=='':
    pass
  print("msg=[{}]".format(msg))
  tag2val = msg.split(DELIMITER)
  t2v = dict()
  for s in tag2val:
    if '=' in s:
      tag, val = s.split('=')
      print("{} => {}".format(tag,val))
      t2v[tag] = val

  print("====t2v====")
  print(t2v)
  row = list()
  for t in input_tags:
    if t in t2v.keys():
      row.append(t2v[t])
    else:
      row.append(' ')
  print("row {}".format(row))
  disp.add_row(row)

if not sys.stdin.isatty():
  input_stream = sys.stdin
  input_tags = sys.argv[1:]
  print("input_tags=[{}]".format(input_tags))
else:
  try:
    input_filename = sys.argv[1]
  except IndexError:
    message = 'need filename as first argument if stdin is not full'
    raise IndexError(message)
  else:
    input_stream = open(input_filename, 'rU')

for tag in input_tags:
  tag_name = tag2name.get(tag)
  print("{}:{}".format(tag, tag_name))
  col_names.append(tag_name)

print("col_names:{}".format(col_names))
disp.field_names = col_names

for line in input_stream:
  l = line.strip()
  if l != '':
    print("[{}]".format(l))
    parseFIXMsg(l)

print(disp)
