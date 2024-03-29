if [ -z $logFormat ] || [ ]"x" == "x$logFormat" ]; then
    logFormat="squid"
fi


cat <<EOF

-- Custom log configuration.

-- Predefined Functions.
--
-- format(table)
--  Returns a format object. The given table supports the following fields:
--    Format (string, required):    log format string
--    Interval (number, optional):  log aggregation interval
--
-- filter.accept(string)
--  Create a filter object that accepts logs matching the filter string.
--
-- filter.reject(string)
--  Create a filter object that drops logs matching the filter string.
--
-- filter.wipe(string)
--  Create a filter object that wipes (read: removes) the log fields specified in the filter string.
--
-- log.ascii(table)
--  Creates an ASCII logging object.
--
-- log.binary(table)
--  Creates a binary logging object.
--
-- log.pipe(table)
--  Creates a logging object that logs to a pipe.
--
-- The log.* functions accept a table that supports the following fields:
--    Filename (string, required):
--    Format (string or format object, required):
--    Header (string, optional):
--    RollingEnabled (boolean, optional):
--    RollingIntervalSec (number, optional):
--    RollingOffsetHr (number, optional):
--    RollingSizeMb (number, optional):
--    Filters (array of filter objects, optional):
--    CollationHosts (array of strings, optional):
--      This parameter may be either a single string or an array of entries.
--      Entries may be strings or arrays of strings. A string specifies a
--      single collation host, which is equivalent to providing an array
--      containing a single string.
--
--      If multiple entries are given, multiple collation hosts are configured
--      and each log entry will be forwarded to every host.
--
--      If an entry is an array of strings, this defines a collation host
--      failover group. The first array entry is the primary collation host
--      and the remaining entries are attached as ordered failover hosts
--      that will be attempted if the primary host fails.
--
--      A single collation host with failover:
--        { {'logs-1.example.com:4567', 'logs-2.example.com:4567'} }
--
--      Multiple collation hosts:
--        {'logs-1.example.com:4567', 'logs-2.example.com:4567'}
--
--      Multiple collation hosts with some failover:
--        {'logs-1.example.com:4567', { 'logs-2.example.com:4567', 'logs-2a.example.com:4567'} }

-- Predefined variables.
--
-- log.roll.none (number)
--  RollingEnabled value to disable all log rolling.
--
-- log.roll.time (number)
--  RollingEnabled value. Roll at a certain time requency, specified
--  by RollingIntervalSec, and RollingOffsetHr.
--
-- log.roll.size (number)
--  RollingEnabled value. Roll when the size exceeds RollingSizeMb.
--
-- log.roll.both (number)
--  RollingEnabled value. Roll when either the specified rolling
--  time is reached or the specified file size is reached.
--
-- log.roll.any (number)
--  RollingEnabled value. Roll the log file when the specified
--  rolling time is reached if the size of the file equals or exceeds
--  the specified size.
--
-- log.protocol.http (number)
-- log.protocol.icp (number)
--  Server protocol constants for constructing %<etype> filters.

-- Removed parameters.
--
-- The following logging object parameters that were supported in
-- the XML configuration file have been removed.
--
-- Protocols:
--      The list of protocols to log is a comma separated list of the
--      protocols that the object logs.  If the log object has no
--      Protocol tag, then it logs all protocols. The Protocol tag
--      simply provides an easy way to create a filter that accepts
--      the specified protocols.
--
--      The log object Protocols parameter is no longer supported. This
--      parameter can be implemented with a filter on the %<etype> (log
--      entry type) log field, eg.
--
--      all = filter.accept(string.format('%%<etype> CONTAIN %d,%d', log.protocol.http, log.protocol.icp))
--      icp_only = filter.accept(string.format('%%<etype> CONTAIN %d', log.protocol.icp))
--      http_only = filter.accept(string.format('%%<etype> CONTAIN %d', log.protocol.http))
--
-- ServerHosts:
--      This parameter provides an easy way to create a filter that logs
--      only the requests to hosts in the comma separated list. Only entries
--      from the named servers will be included in the log file. Servers
--      can only be specified by name, not by IP address.
--
--      The log object ServerHosts parameter is no longer supported. It can
--      implemented with a filter on the %<shn> (server host name) log
--      field, eg.
--
--      hosts = filter.accept('%<shn> CASE_INSENSITIVE_CONTAIN host1,host2,host3,etc")

-- WebTrends Enhanced Log Format.
--
-- The following is compatible with the WebTrends Enhanced Log Format.
-- If you want to generate a log that can be parsed by WebTrends
-- reporting tools, simply create a log that uses this format.
welf = format {
  Format = 'id=firewall time="%<cqtd> %<cqtt>" fw=%<phn> pri=6 proto=%<cqus> duration=%<ttmsf> sent=%<psql> rcvd=%<cqhl> src=%<chi> dst=%<shi> dstname=%<shn> user=%<caun> op=%<cqhm> arg="%<cqup>" result=%<pssc> ref="%<{Referer}cqh>" agent="%<{user-agent}cqh>" cache=%<crc>'
}

-- Squid Log Format with seconds resolution timestamp.
--
-- The following is the squid format but with a seconds-only timestamp
-- (cqts) instead of a seconds and milliseconds timestamp (cqtq).
squid_seconds_only_timestamp = format {
  Format = '%<cqts> %<ttms> %<chi> %<crc>/%<pssc> %<psql> %<cqhm> %<cquc> %<caun> %<phr>/%<pqsn> %<psct>'
}

-- https://docs.trafficserver.apache.org/en/6.2.x/admin-guide/monitoring/logging/log-formats.en.html#custom-logging-fields

-- Squid Log Format.
-- stms: The time spent accessing the origin (in milliseconds); the time is measured from the time the connection with the origin is established to the time the connection is closed.
-- cqtq: The client request timestamp in Squid format. The time of the client request in seconds since January 1, 1970 UTC (with millisecond resolution).
-- chi: The IP address of the client’s host machine.
-- %<crc>/%<pssc>:  HIT/200
-- sstc: The number of transactions between Traffic Server and the origin server from a single server session. A value greater than 0 indicates connection reuse.
-- ttms: The time Traffic Server spends processing the client request; the number of milliseconds between the time the client establishes the connection with Traffic Server and the time Traffic Server sends the last byte of the response back to the client.
rich = format {
  Format = '%<cqtq> %<ttms> %<chi> %<stms> %<sstc> %<crc>/%<pssc> %<psql> %<cqhm> %<cquc> %<caun> %<phr>/%<pqsn> %<psct>'
}

squid = format {
  Format = '%<cqtq> %<ttms> %<chi> %<crc>/%<pssc> %<psql> %<cqhm> %<cquc> %<caun> %<phr>/%<pqsn> %<psct>'
}

-- Common Log Format.
common = format {
  Format = '%<chi> - %<caun> [%<cqtn>] "%<cqtx>" %<pssc> %<pscl>'
}

-- Extended Log Format.
extended = format {
  Format = '%<chi> - %<caun> [%<cqtn>] "%<cqtx>" %<pssc> %<pscl> %<sssc> %<sscl> %<cqcl> %<pqcl> %<cqhl> %<pshl> %<pqhl> %<sshl> %<tts>'
}

-- Extended2 Log Formats
extended2 = format {
  Format = '%<chi> - %<caun> [%<cqtn>] "%<cqtx>" %<pssc> %<pscl> %<sssc> %<sscl> %<cqcl> %<pqcl> %<cqhl> %<pshl> %<pqhl> %<sshl> %<tts> %<phr> %<cfsc> %<pfsc> %<crc>'
}

-- log.binary {
--     Format = squid,
--     Filename = 'squid'
-- }
log.ascii {
  Format = $logFormat,
  Filename = 'squid'
}
-- vim: set ft=lua :

EOF

