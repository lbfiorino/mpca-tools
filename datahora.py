# -*- coding: utf-8 -*-

# --------------------------------------------------
# Requirements:
# --------------------------------------------------
# python -m pip install pytz python-dateutil


# --------------------------------------------------
# References:
# --------------------------------------------------
# https://dateutil.readthedocs.io/en/stable/index.html
# https://pythonhosted.org/pytz/
# https://www.alura.com.br/artigos/lidando-com-datas-e-horarios-no-python
# https://www.geeksforgeeks.org/python-datetime-tzinfo/


from datetime import datetime
from datetime import timezone
import pytz
from dateutil import tz
from dateutil.zoneinfo import get_zonefile_instance


##---------------------------------------------------------------
## PYTZ
##---------------------------------------------------------------

tz_LA = pytz.timezone("America/Los_Angeles")
tz_SP = pytz.timezone("America/Sao_Paulo")

LA = datetime.now(tz_LA)
SP = datetime.now(tz_SP)
UTC = datetime.now(pytz.UTC)

print("\nUtilizando PYTZ")
print("-----------------")
print(f"{'Hora Los Angeles:':>20} {LA}")
print(f"{'Hora São Paulo:':>20} {SP}")
print(f"{'Hora UTC:':>20} {UTC}")


# Print timezones
# for tz in pytz.all_timezones:
#     print(tz)

##---------------------------------------------------------------


##---------------------------------------------------------------
## DATEUTIL TZ
##---------------------------------------------------------------


TZ_NY = tz.gettz('America/New_York') 
TZ_HK = tz.gettz('Asia/Hong_Kong') 
TZ_UTC = tz.gettz('UTC')

NY = datetime.now(TZ_NY)
HK = datetime.now(TZ_HK)
UTC = datetime.now(TZ_UTC)

print("\nUtilizando DATEUTIL")
print("-------------------")
print(f"{'Hora New York:':>20} {NY}")
print(f"{'Hora Hong Kong:':>20} {HK}")
print(f"{'Hora UTC:':>20} {UTC}")


# Print timezones
# zonenames = list(get_zonefile_instance().zones)
# zonenames.sort()
# for z in zonenames:
#     print(z)

##---------------------------------------------------------------


##---------------------------------------------------------------
## MUDANDO TIMEZONE DA DATA/HORA
##---------------------------------------------------------------

print("\nMudando timezone de um DATETIME")
print("-------------------------------")
# Local Time
NOW = datetime.now()
# UTC Time
NOW_utc = datetime.utcnow()

print(f"{'Hora atual:':>20} {NOW}")

# Change timzezone to Rome using PYTZ
ROME = NOW.astimezone(pytz.timezone("Europe/Rome"))
print(f"{'Hora Roma:':>20} {ROME} (pytz)")

# Change timzezone to Tokyo using DATEUTIL
TOKYO = NOW.astimezone(tz.gettz('Asia/Tokyo'))
print(f"{'Hora Tóquio:':>20} {TOKYO} (dateutil)")

# Change timzezone to UTC
UTC_pytz = NOW.astimezone(pytz.UTC)
UTC_dateutil = NOW.astimezone(tz.gettz('UTC'))
print(f"{'Hora UTC:':>20} {NOW} (pytz)")
print(f"{'Hora UTC:':>20} {NOW} (dateutil)")


