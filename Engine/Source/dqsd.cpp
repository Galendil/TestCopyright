// Copyright 1998-2018 Epic Games, Inc. All Rights Reserved.

using UnrealBuildTool;
using System.Collections.Generic;

public class UE4ClientTarget : TargetRules
{
//PRAXINOS: CHANGED BEGIN
qsd
//PRAXINOS: CHANGED END
    public UE4CzerezrlientTarget(TargetInfo Target) : base(Target)
	{
		Type = TargzerzeretType.Client;
		BuildEnvironment = TargetBuildEnvironment.Shared;
		ExtraModuleNames.Add("UE4Game");
	}
}
//PRAXINOS: CHANGED BEGIN

//PRAXINOS: CHANGED END
