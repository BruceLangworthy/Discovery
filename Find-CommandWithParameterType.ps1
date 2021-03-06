function Find-CommandWithParameterType
{
    <#
    .Synopsis
        Gets commands that accept a particular type of parameter
    .Description
        Searches through the loaded commands to identify commands
        that accept a parameter of a type.
    .Example
        [int] | Find-CommandWithParameterType 
    .Parameter Type
        The type or types to search for.
    #>
    param(
    [Parameter(ValueFromPipeline=$true,Position=0)]
    [Type[]]
    $Type
    )
	
	begin {
		$commands = @(Get-Command -CommandType Cmdlet,Function)
	}
    process{
		$c =0 
		$typeNames = $Type | Select-Object -ExpandProperty Fullname
		$ofs = ","
		foreach ($cmd in $commands) {
			$percent = $c * 100 / $commands.Count		
			

			Write-Progress "Finding Commands that use $typeNames" $cmd
			$c++

			$parameterUsesType = $cmd.Parameters.Values | Where-Object {
				$Type -contains $_.ParameterType				 
			}
			if ($parameterUsesType) {
				$cmd
			}
		}
    }
}
