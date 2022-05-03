---
layout: post
title: "PowerShell Script to Log Network Connections"
excerpt: "The Log-Connections.ps1 file is a PowerShell Script that Logs active
TCP connections and includes the process ID (PID) and process name for each
connection on a Microsoft Windows computer."
modified: 2012-12-17
tags: [PowerShell]
comments: false
category: blog
---


## General Description

The <a href="/media/Log-Connections.zip">Log-Connections.ps1</a> file is a
PowerShell Script that Logs active TCP connections and includes the process ID
(PID) and process name for each connection on a Microsoft Windows computer. 
The log file name is a parameter that is passed to the script at run time.  A
log entry is created every time that the list of processes with open
connections or listening ports changes.  If the ports or remote addresses are
not yet established, they are shown as an asterisk (*).

The Log-Connections script is based on the netstat command, “netstat
–nao,” which can be run at the Windows command prompt to display a snapshot
of all connections and listening ports.  The –o switch tells netstat to
display the owning process ID that is associated with each process.  A
limitation of the netstat command is that it cannot report the associated
process name, just the PID.   To achieve this, the Log-Connections PowerShell
script calls the Get-NetworkStatistics function.   This function was written
by <a href="http://blogs.microsoft.co.il/ScriptFanatic/"  target="_blank"
rel="noreferrer noopener">>Shay Levy</a> and is available at <a
href="/dead-link/">http://poshcode.org/2701</a> .

The Log-Connections script calls the `Get-NetworkStatistics` function
repeatedly in an infinite loop, comparing the current snapshot with the
previous.  If there is a change, the current snapshot is time stamped, logged
to the file, and optionally passed through to the PowerShell pipeline.

Passing the connections snapshot object through to the PowerShell pipeline
allows the data to be manipulated or displayed in real-time by other PowerShell
cmdlets.  This will be illustrated in the examples that follow.

## Quick Intro to PowerShell

Windows PowerShell is a command-line shell and a scripting language that is
built upon the .NET Framework. PowerShell has been around since 2006, but is
included in the base OS with Windows 7 and Windows Server 2008 R2.

![Search Box](/images/SearchBox.png)

PowerShell can be invoked by typing “powershell” in the search box above
the Windows Start Button, or by typing “powershell” at the Windows command
prompt.

A great website to learn more about PowerShell is at <a
href="http://www.powershellpro.com/powershell-tutorial-introduction/"
rel="nofollow">http://www.powershellpro.com/powershell-tutorial-introduction/</a
>.

## PowerShell Security Features

PowerShell has an script execution policy that by default will prevent scripts
from being executed unintentionally.  To learn more about execution policies,
type the following command in PowerShell:

```
Get-Help about_Execution_Policies
```

To be able to run the following examples, it is suggested that you change the
execution policy to “RemoteSigned” so that local scripts can run unsigned
and remote scripts can only run if signed by a trusted entity.  To do this run
the following PowerShell command:

```
Set-ExecutionPolicy RemoteSigned –scope CurrentUser
```

To revert back to the default, just type:

```
Set-ExecutionPolicy Restricted
```

Another feature of PowerShell is that scripts cannot be executed in the current
directory by typing just the script name.  Instead they must be prefaced with
a dot and a backslash, ( “.\”).  This is illustrated in the examples below.

## EXAMPLE 1

```
powershell .\Log-Connections.ps1 c:\workspace\mylog.csv
```

![Example1](/images/Example-1.png)

Example 1 shows the Log-Connections.ps1 script being invoked from the Windows
command prompt. The ps1 script and the complete path to the log file are passed
in as arguments the command “powershell.”  Also note the use the file
extension of “CSV.”  This is convenient because on many systems when a CSV
file is double clicked it will launch Microsoft Excel.  Any other extension,
including “TXT” is also acceptable.

## EXAMPLE 2

```
powershell c:\Temp\Log-Connections.ps1 mylog.csv svchost
```

![Example2](/images/Example-2.png)

Example 2 is very similar to the first one except a process name has been
passed in as an argument and just the file name (without the path) has been
provided, so the log file will be saved in the current directory,
c:\workspace.  The full path to the script is provided because it is in
c:\temp.

Note: if the log file exists already, the new observations will be appended to
the bottom

## EXAMPLE 3

```
powershell .\Log-Connections.ps1 mylog.csv svchost -PassThru
```

![Example3](/images/Example-3.png)

Using the “-PassThru” switch will cause the script display the results to
the screen in a raw format in addition to logging them in the log file.

## EXAMPLE 4

```
.\Log-Connections.ps1 -ProcName svchost -Filepath mylog.csv
```

![Example4](/images/Example-4.png)

In Example 4 the user typed `powershell` at the command prompt to invoke
PowerShell. Then the name of the script and its arguments were typed at the
PowerShell prompt.

This example also demonstrated the use of the named parameters convention. 
Passing in the parameter value (e.g. “mylog.csv”)  after the parameter
name `-Filepath` allows the parameters to be passed in out of order.

## EXAMPLE 5

```
.\Log-Connections.ps1
```

![Example3](/images/Example-5.png)

Example 5 shows that PowerShell will gracefully request any missing parameters
that are mandatory. In this case it is the FilePath value.

## EXAMPLE 6

```
.\Log-Connections.ps1 mylog.csv svchost -PassThru | Format-Table
```

![Example6](/images/Example-6.png)

Example 6 illustrates piping the output of the Log-Connections script to the
Format-Table cmdlet.  The Format-Table cmdlet produces a nice table of the
results that will grow in real time.

## EXAMPLE 7

```
.\Log-Connections.ps1 mylog.csv iexplore -PassThru | Out-GridView
```

![Example7](/images/Example-7.png)

Using the Out-Gridview cmdlet, as shown in Example 7, will produce a grid of
the results.  The grid grows in real time and can be filtered and sorted. 
The columns can also be re-arranged.

![Example7](/images/Example-Grid.png)

The grid can also be filtered using the “Add Criteria” button as shown
below:

![Example Filtered Grid](/images/Example-Filtered-Grid.png)

```
#* FileName: Log-Connections.ps1
 #*=============================================================================
 #* Script Name: Log-Connections
 #* Created:     [12/1/2012]
 #* Author:      Kenneth G. Hartman
 #* Email:       KGH@kennethGHartman.com
 #* Web:         https://kennethghartman.com
 #*
 #* CREDITS:    Author of the Get-NetworkStatistics Function is
 #*             Shay Levy   http://PowerShay.com  http://poshcode.org/2701
 #*        http://blogs.microsoft.co.il/blogs/scriptfanatic/archive/2011/02/10/
 #*        How-to-find-running-processes-and-their-port-number.aspx
 #*=============================================================================

#*=============================================================================
 #* REVISION HISTORY
 #*=============================================================================
 #* Date: [12/16/2012]
 #* Description: Initial Version
 #*
 #*=============================================================================

[CmdletBinding()]
Param(
   [Parameter(Mandatory=$True,Position=0)]
   [string]$FilePath,

   [Parameter(Mandatory=$False,Position=1)]
   [string]$ProcName='*',

   [switch]$PassThru
)

#*******************************************
#* Get-NetworkStatistics Function          *
#*******************************************

function Get-NetworkStatistics
{
    [OutputType('System.Management.Automation.PSObject')]
    [CmdletBinding(DefaultParameterSetName='name')]

    param(
        [Parameter(Position=0,ValueFromPipeline=$true,ParameterSetName='port')]
        [System.Int32]$Port='*',

        [Parameter(Position=0,ValueFromPipeline=$true,ParameterSetName='name')]
        [System.String]$ProcessName='*',


[Parameter(Position=0,ValueFromPipeline=$true,ParameterSetName='address')]
        [System.String]$Address='*',

        [Parameter()]
        [ValidateSet('*','tcp','udp')]
        [System.String]$Protocol='*',

        [Parameter()]

[ValidateSet('*','Closed','CloseWait','Closing','DeleteTcb','Established','FinWa
it1',`

'FinWait2','LastAck','Listen','SynReceived','SynSent','TimeWait','Unknown')]
        [System.String]$State='*'

    )

    begin
    {
        $properties = 'Protocol','LocalAddress','LocalPort'
            $properties +=
'RemoteAddress','RemotePort','State','ProcessName','PID'
    }

    process
    {
        netstat -ano | Select-String -Pattern '\s+(TCP|UDP)' | ForEach-Object {

            $item = $_.line.split('
',[System.StringSplitOptions]::RemoveEmptyEntries)

            if($item[1] -notmatch '^\[::')
            {
                if (($la = $item[1] -as [ipaddress]).AddressFamily -eq
'InterNetworkV6')
                {
                   $localAddress = $la.IPAddressToString
                   $localPort = $item[1].split('\]:')[-1]
                }
                else
                {
                    $localAddress = $item[1].split(':')[0]
                    $localPort = $item[1].split(':')[-1]
                }

                if (($ra = $item[2] -as [ipaddress]).AddressFamily -eq
'InterNetworkV6')
                {
                   $remoteAddress = $ra.IPAddressToString
                   $remotePort = $item[2].split('\]:')[-1]
                }
                else
                {
                   $remoteAddress = $item[2].split(':')[0]
                   $remotePort = $item[2].split(':')[-1]
                }

                $procId = $item[-1]
                $ProcName = (Get-Process -Id $item[-1] -ErrorAction
SilentlyContinue).Name
                $proto = $item[0]
                $status = if($item[0] -eq 'tcp') {$item[3]} else {$null}


                $pso = New-Object -TypeName PSObject -Property @{
                    PID = $procId
                    ProcessName = $ProcName
                    Protocol = $proto
                    LocalAddress = $localAddress
                    LocalPort = $localPort
                    RemoteAddress =$remoteAddress
                    RemotePort = $remotePort
                    State = $status
                } | Select-Object -Property $properties


                if($PSCmdlet.ParameterSetName -eq 'port')
                {
                    if($pso.RemotePort -like $Port -or $pso.LocalPort -like
$Port)
                    {
                        if($pso.Protocol -like $Protocol -and $pso.State -like
$State)
                        {
                            $pso
                        }
                    }
                }

                if($PSCmdlet.ParameterSetName -eq 'address')
                {
                    if($pso.RemoteAddress -like $Address -or $pso.LocalAddress
-like $Address)
                    {
                        if($pso.Protocol -like $Protocol -and $pso.State -like
$State)
                        {
                            $pso
                        }
                    }
                }

                if($PSCmdlet.ParameterSetName -eq 'name')
                {
                    if($pso.ProcessName -like $ProcessName)
                    {
                        if($pso.Protocol -like $Protocol -and $pso.State -like
$State)
                        {
                               $pso
                        }
                    }
                }
            }
        }
    }
<#
.SYNOPSIS
    Displays the current TCP/IP connections.

.DESCRIPTION
    Displays active TCP connections and includes the process ID (PID) and Name
for each connection.
    If the port is not yet established, the port number is shown as an asterisk
(*).

.PARAMETER ProcessName
    Gets connections by the name of the process. The default value is '*'.

.PARAMETER Port
    The port number of the local computer or remote computer. The default value
is '*'.

.PARAMETER Address
    Gets connections by the IP address of the connection, local or remote.
Wildcard is supported.
    The default value is '*'.

.PARAMETER Protocol
    The name of the protocol (TCP or UDP). The default value is '*' (all)

.PARAMETER State
    Indicates the state of a TCP connection. The possible states are as follows:

    Closed      - The TCP connection is closed.
    CloseWait   - The local endpoint of the TCP connection is waiting for a
connection termination
                  request from the local user.
    Closing     - The local endpoint of the TCP connection is waiting for an
acknowledgement of the
                  connection termination request sent previously.
    DeleteTcb   - The transmission control buffer (TCB) for the TCP connection
is being deleted.
    Established - The TCP handshake is complete. The connection has been
established and data
                  can be sent.
    FinWait1    - The local endpoint of the TCP connection is waiting for a
connection termination
                  request from the remote endpoint or for an acknowledgement of
the connection
                  termination request sent previously.
    FinWait2     - The local endpoint of the TCP connection is waiting for a
connection termination
                  request from the remote endpoint.
    LastAck     - The local endpoint of the TCP connection is waiting for the
final acknowledgement
                  of the connection termination request sent previously.
    Listen      - The local endpoint of the TCP connection is listening for a
connection request
                  from any remote endpoint.
    SynReceived - The local endpoint of the TCP connection has sent and
received a connection request
                  and is waiting for an acknowledgment.
    SynSent     - The local endpoint of the TCP connection has sent the remote
endpoint a segment
                  header with the synchronize (SYN) control bit set and is
waiting for a matching
                  connection request.
    TimeWait    - The local endpoint of the TCP connection is waiting for
enough time to pass to
                  ensure that the remote endpoint received the acknowledgement
of its connection
                  termination request.
    Unknown     - The TCP connection state is unknown.

    Values are based on the TcpState Enumeration:

http://msdn.microsoft.com/en-us/library/system.net.networkinformation.tcpstate%2
8VS.85%29.aspx

.EXAMPLE
    Get-NetworkStatistics

.EXAMPLE
    Get-NetworkStatistics iexplore

.EXAMPLE
    Get-NetworkStatistics -ProcessName md* -Protocol tcp

.EXAMPLE
    Get-NetworkStatistics -Address 192* -State LISTENING

.EXAMPLE
    Get-NetworkStatistics -State LISTENING -Protocol tcp

.OUTPUTS
    System.Management.Automation.PSObject

.NOTES
    Author: Shay Levy
    Blog  : http://PowerShay.com
#>
}

#*******************************************
#*                MAIN PROGRAM             *
#*******************************************

#Add Header to the CSV File
[string]$Previous = "TimeStamp,Protocol,LocalAddress,LocalPort,RemoteAddress,"
$Previous += "RemotePort,State,ProcessName,PID"
Add-Content $FilePath $Previous

#Initiate an infinite loop that calls the Get-NetworkStatistics Function
repeatedly
#and formats the output as appropriate
while ($true) {
    $Observation = Get-NetworkStatistics $ProcName
    [string]$Current = $Observation | Out-String
    if ($Previous -ne $Current) {
        [string]$TimeStamp = Get-Date -Format o
        $Previous = $Current
        ForEach ($Socket in $Observation) {
            $Record = $TimeStamp + "," + $Socket.Protocol + "," +
$Socket.LocalAddress + "," `
            + $Socket.LocalPort + "," + $Socket.RemoteAddress + "," +
$Socket.RemotePort + "," `
            + $Socket.State + "," + $Socket.ProcessName  + "," + $Socket.PID
            Add-Content $FilePath $Record
            if ($PassThru) {
                $pso2 = New-Object -TypeName PSObject -Property @{
                    PID = $Socket.PID
                    ProcessName = $Socket.ProcessName
                    Protocol = $Socket.Protocol
                    LocalAddress = $Socket.LocalAddress
                    LocalPort = $Socket.LocalPort
                    RemoteAddress = $Socket.RemoteAddress
                    RemotePort = $Socket.RemotePort
                    State = $Socket.State
                    TimeStamp = $TimeStamp
                } | Select-Object -Property $properties

                Write-Output $pso2
                }
            }
        }
    }

<#
.SYNOPSIS
    Creates a log of current TCP/IP connections and optionally passes them
through to the pipeline.

.DESCRIPTION
    Logs active TCP connections and includes the process ID (PID) and Name for
each connection.
    If the port is not yet established, the port number is shown as an asterisk
(*).

.PARAMETER FilePath
    The path and file name of the log file. Mandatory.

.PARAMETER ProcName
    Log only connections with the name of the process provided. The default
value is '*'.

.SWITCH PassThru
    Return a process object to the screen or the pipeline.

.EXAMPLE
    Log-Connections mylog.csv

.EXAMPLE
    Log-Connections mylog.csv svchost

.EXAMPLE
    Log-Connections mylog.csv svchost -PassThru

.EXAMPLE
    Log-Connections -Filepath mylog.csv -ProcName svchost

.EXAMPLE
    Log-Connections mylog.csv svchost -PassThru | Format-Table

.EXAMPLE
    Log-Connections mylog.csv svchost -PassThru | Out-GridView

.OUTPUTS
    System.Management.Automation.PSObject

.NOTES
    Author : Kenneth G. Hartman
    Blog   : https://kennethghartman.com
    Credits: Author of the Get-NetworkStatistics Function is
             Shay Levy   http://PowerShay.com  http://poshcode.org/2701
#>
```
