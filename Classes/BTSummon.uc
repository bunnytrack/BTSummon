class BTSummon expands Mutator;

var bool   bInitialised;
var string UTPackages[4], Monstra[39];

function PreBeginPlay() {
	if (bInitialised) {
		return;
	}

	Level.Game.BaseMutator.AddMutator(self);
	bInitialised = true;
}

simulated event PostBeginPlay() {
	Log("");
	Log("+--------------------------------------------------------------------------+");
	Log("| BTSummon                                                                 |");
	Log("| ------------------------------------------------------------------------ |");
	Log("| Author      : Sapphire <sapphire@bunnytrack.net>                         |");
	Log("| Description : Summon things with corrected rotation.                     |");
	Log("| Version     : 2019-01-26                                                 |");
	Log("| ------------------------------------------------------------------------ |");
	Log("| Released under the Creative Commons Attribution-NonCommercial-ShareAlike |");
	Log("| license. See https://creativecommons.org/licenses/by-nc-sa/4.0/          |");
	Log("+--------------------------------------------------------------------------+");
	Log("");

	AssignMonstra();

	UTPackages[0] = "";
	UTPackages[1] = "Botpack.";
	UTPackages[2] = "UnrealI.";
	UTPackages[3] = "UnrealShare.";
}

function Mutate(string MutateString, PlayerPawn Sender) {
	local class<actor> NewClass;
	local string action, param1, param2, param3;
	local int    i;
	local vector x, y, z;

	// This mutator is for admins only.
	if (Sender.bAdmin) {

		// Split mutate string into action/parameter variables.
		SplitMutateString(MutateString, action, param1, param2, param3);

		if (action ~= "summon") {

			// Spawn a random monster if using Monstra.
			if (param1 ~= "Monstra") {
				param1 = "UnrealI." $ Monstra[Rand(ArrayCount(Monstra))];
			}

			// Get sender's axes so things can be spawned with the desired rotation.
			GetAxes(Sender.ViewRotation, x, y, z);

			/**
			 * Iterate through UTPackages and DynamicLoadObject() using each package name. An empty
			 * string is used as the first "package" as a hack to avoid repetition of the Spawn()
			 * function.
			 *
			 * Example usage: summon rocket -> summon UnrealI.rocket -> summon Botpack.rocket
			 */
			for (i = 0; i < ArrayCount(UTPackages); i++) {
				NewClass = class<actor>(DynamicLoadObject(UTPackages[i] $ param1, class'Class'));

				if (NewClass != none) {
					Spawn(NewClass,,, Sender.Location + 72 * Vector(Sender.Rotation), Rotator(x));
					return;
				}
			}

			// If this point is reached, nothing has been spawned.
			Sender.ClientMessage("Unable to spawn \"" $ param1 $ "\".");
		}
	}

	if (NextMutator != none) {
		NextMutator.Mutate(MutateString, Sender);
	}
}

/**
 * Populate Monstra array with monster names.
 */
function AssignMonstra() {
	Monstra[0]  = "BabyCow";
	Monstra[1]  = "Bird1";
	Monstra[2]  = "Brute";
	Monstra[3]  = "CaveManta";
	Monstra[4]  = "Cow";
	Monstra[5]  = "DevilFish";
	Monstra[6]  = "Fly";
	Monstra[7]  = "Gasbag";
	Monstra[8]  = "GiantGasbag";
	Monstra[9]  = "GiantManta";
	Monstra[10] = "IceSkaarj";
	Monstra[11] = "Krall";
	Monstra[12] = "KrallElite";
	Monstra[13] = "LeglessKrall";
	Monstra[14] = "Manta";
	Monstra[15] = "Mercenary";
	Monstra[16] = "MercenaryElite";
	Monstra[17] = "Nali";
	Monstra[18] = "NaliPriest";
	Monstra[19] = "NaliRabbit";
	Monstra[20] = "Pupae";
	Monstra[21] = "Queen";
	Monstra[22] = "Skaarj";
	Monstra[23] = "SkaarjAssassin";
	Monstra[24] = "SkaarjBerserker";
	Monstra[25] = "SkaarjGunner";
	Monstra[26] = "SkaarjInfantry";
	Monstra[27] = "SkaarjLord";
	Monstra[28] = "SkaarjOfficer";
	Monstra[29] = "SkaarjScout";
	Monstra[30] = "SkaarjSniper";
	Monstra[31] = "SkaarjTrooper";
	Monstra[32] = "SkaarjWarrior";
	Monstra[33] = "Slith";
	Monstra[34] = "Squid";
	Monstra[35] = "StoneTitan";
	Monstra[36] = "Tentacle";
	Monstra[37] = "Titan";
	Monstra[38] = "Warlord";
}

/**
 * Splits a space-separated string into parameters.
 */
function SplitMutateString(string mString, out string action, out string param1, out string param2, out string param3) {
	if (InStr(mString, " ") != -1) {
		action = Left(mString, InStr(mString, " "));
		param1 = Right(mString, Len(mString) - InStr(mString, " ") - 1);

		if (InStr(param1, " ") != -1) {
			param2 = Right(param1, Len(param1) - InStr(param1, " ") - 1);
			param1 = Left(param1, InStr(param1, " "));

			if (InStr(param2, " ") != -1) {
				param3 = Right(param2, Len(param2) - InStr(param2, " ") - 1);
				param2 = Left(param2, InStr(param2, " "));
			}
		}
	} else {
		action = mString;
	}
}