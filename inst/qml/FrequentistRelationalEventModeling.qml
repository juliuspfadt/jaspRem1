import QtQuick
import QtQuick.Layouts
import JASP
import JASP.Controls

Form
{

	VariablesForm
	{
		preferredHeight: 200 * preferencesModel.uiScale
		AvailableVariablesList{	name:	"allVariablesList" }
		AssignedVariablesList	{	name:	"time";			title: qsTr("Time Variable");		suggestedColumns: ["scale"];							singleVariable: true	}
		AssignedVariablesList	{	name:	"actors";		title: qsTr("Actor Variables");	suggestedColumns: ["scale","ordinal", "nominal"]; singleVariable: false; height: 75 * preferencesModel.uiScale}
		AssignedVariablesList	{	name:	"weight";		title: qsTr("Weight Variable");	suggestedColumns: ["scale"];							singleVariable: true	}
	}

	Section
	{
		title: qsTr("Model")
		columns: 2

		RadioButtonGroup
		{
			name: "eventDirection"
			id: eventDirection
			title: qsTr("Event direction")
			radioButtonsOnSameRow: false

			RadioButton
			{
				value: "directed"
				label: qsTr("Directed")
				checked: true
			}
			RadioButton
			{
				value: "undirected"
				label: qsTr("Undirected")
			}
		}

		RadioButtonGroup
		{
			name: "eventSequence"
			title: qsTr("Event sequence")
			radioButtonsOnSameRow: false

			RadioButton
			{
				value: "timeSensitive"
				label: qsTr("Time sensitive")
				checked: true
			}
			RadioButton
			{
				value: "orderOnly"
				label: qsTr("Order only")
			}
		}

		RadioButtonGroup
		{
			name: "modelOrientation"
			id: modelOrientation
			title: qsTr("Model orientation")
			radioButtonsOnSameRow: false

			RadioButton
			{
				value: "tieOriented"
				label: qsTr("Tie-oriented")
				checked: true
			}
			RadioButton
			{
				value: "actorOriented"
				label: qsTr("Actor-oriented")
			}
		}

		RadioButtonGroup
		{
			name: "riskset"
			title: qsTr("Riskset")
			radioButtonsOnSameRow: false

			RadioButton
			{
				value: "full"
				label: qsTr("Full")
				checked: true
			}
			RadioButton
			{
				value: "active"
				label: qsTr("Active")
			}
			RadioButton
			{
				value: "manual"
				label: qsTr("Manual")
			}
		}
	}

 // section visible for the tie-oriented directed model
	Section 
	{
		title: qsTr("Effects")
		columns: 1
		visible: modelOrientation.value == "tieOriented" && eventDirection.value == "directed"

		VariablesForm
		{
			preferredHeight: 100 * preferencesModel.uiScale
			AvailableVariablesList 
			{ 
				name: "possibleEndogenousEffectsTieDirected"; 
				title: qsTr("Endogenous effects")
				values:
				[
					{ label: qsTr("In degree receiver"),						value: "indegreeReceiver"				},
					{ label: qsTr("In degree sender"),							value: "indegreeSender"					},
					{ label: qsTr("Fixed effects for event type"),	value: "FEtype"						},
					{ label: qsTr("Inertia"),												value: "inertia"					},
					{ label: qsTr("Incoming shared partners"),			value: "isp"										},
					{ label: qsTr("Incoming two-path"),							value: "itp"										},
					{ label: qsTr("Outgoing shared partners"),			value: "osp"										},
					{ label: qsTr("Outgoing two-path"),							value: "otp"										},
					{ label: qsTr("Out deregee receiver"),					value: "outdegreeReceiver"			},
					{ label: qsTr("Out degree sender"),							value: "outdegreeSender"				},
					{ label: qsTr("Pshift AB-AB"),									value: "psABAB"						},
					{ label: qsTr("Pshift AB-AY"),									value: "psABAY"						},
					{ label: qsTr("Pshift AB-BA"),									value: "psABBA"									},
					{ label: qsTr("Pshift AB-BY"),									value: "psABBY"									},
					{ label: qsTr("Pshift AB-XA"),									value: "psABXA"									},
					{ label: qsTr("Pshift AB-XB"),									value: "psABXB"									},
					{ label: qsTr("Pshift AB-XY"),									value: "psABXY"									},
					{ label: qsTr("Recency continue"),							value: "recencyContinue"	},
					{ label: qsTr("Recency receive of receiver"), 	value: "recencyReceiveReceiver"	},
					{ label: qsTr("Recency receive of sender"),			value: "recencyReceiveSender"		},
					{ label: qsTr("Recency send of receiver"),			value: "recencySendReceiver"		},
					{ label: qsTr("Recency send of sender"),				value: "recencySendSender"			},
					{ label: qsTr("Reciprocity"),										value: "reciprocity"						},
					{ label: qsTr("Recency rank receive"),					value: "rrankReceive"						},
					{ label: qsTr("Recency rank send"),							value: "rrankSend"							},
					{ label: qsTr("Total degree dyad"),							value: "totaldegreeDyad"	},
					{ label: qsTr("Total degree receiver"),					value: "totaldegreeReceiver"		},
					{ label: qsTr("Total degree sender"),						value: "totaldegreeSender"			},
					{ label: qsTr("User statistics"),								value: "userStat"					}
				]
			}

			AssignedVariablesList { name: "specifiedEndogenousEffectsTieDirected"}

		}

		DropDown
		{
			id: exDropTieDir
			name: "exogenousEffectsTieDirected"
			label: qsTr("Exogenous effects")
			addEmptyValue: true
			values:
			[
				{ label: qsTr("Average"),			value: "averageEffect"		},
				{ label: qsTr("Difference"),	value: "differenceEffect"	},
				{ label: qsTr("Event"),				value: "eventEffect"			},
				{ label: qsTr("Maximum"),			value: "maximumEffect"		},
				{ label: qsTr("Minimum"),			value: "minimumEffect"		},
				{ label: qsTr("Receive"),			value: "receiveEffect"		},
				{ label: qsTr("Same"),				value: "sameEffect"				},
				{ label: qsTr("Send"),				value: "sendEffect"				},
				{ label: qsTr("Tie"),					value: "tieEffect"				}
			]
		}

		VariablesForm
		{
			preferredHeight: 200 * preferencesModel.uiScale
			AvailableVariablesList{	name:	"effectsVariablesListTieDirected"; source: "allVariablesList"}
			
			AssignedVariablesList	
			{	
				name:	"averageEffectBoxTieDirected"
				title: qsTr("Average effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["averageEffect"].includes(exDropTieDir.value)
			}
			AssignedVariablesList	
			{	
				name:	"differenceEffectBoxTieDirected"
				title: qsTr("Difference effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["differenceEffect"].includes(exDropTieDir.value)
			}
			AssignedVariablesList	
			{	
				name:	"eventEffectBoxTieDirected"
				title: qsTr("Event effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["eventEffect"].includes(exDropTieDir.value)
			}
			AssignedVariablesList	
			{	
				name:	"maximumEffectBoxTieDirected"
				title: qsTr("Maximum effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["maximumEffect"].includes(exDropTieDir.value)
			}
			AssignedVariablesList	
			{	
				name:	"minimumEffectBoxTieDirected"
				title: qsTr("Minimum effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["minimumEffect"].includes(exDropTieDir.value)
			}
			AssignedVariablesList	
			{	
				name:	"receiveEffectBoxTieDirected"
				title: qsTr("Receive effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["receiveEffect"].includes(exDropTieDir.value)
			}
			AssignedVariablesList	
			{	
				name:	"sameEffectBoxTieDirected"
				title: qsTr("Same effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["sameEffect"].includes(exDropTieDir.value)
			}
			AssignedVariablesList	
			{	
				name:	"sendEffectBoxTieDirected"
				title: qsTr("Send effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["sendEffect"].includes(exDropTieDir.value)
			}
			AssignedVariablesList	
			{	
				name:	"tieEffectBoxTieDirected"
				title: qsTr("Tie effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["tieEffect"].includes(exDropTieDir.value)
			}
		}

		// Group
		// {
		// 	title: qsTr("Interaction Effects")
		// 	VariablesForm
		// 	{
		// 		preferredHeight: 200 * preferencesModel.uiScale
		// 		AvailableVariablesList
		// 		{	
		// 			name:	"interactionEffectsList"
		// 			source: ["groupEffectVariable", "weekendEffectVariable", "settingEffectVariable", "differenceEffectVariables", "minimumEffectVariables", "maximumEffectVariables"] 
		// 		}
		// 		AssignedVariablesList	
		// 		{
		// 			name:	"interactions"
		// 			title: qsTr("Model interactions")
		// 			listViewType: JASP.Interaction
		// 			addAvailableVariablesToAssigned: false
		// 		}
		// 	}
		// }
	}

 // section visible for the tie-oriented undirected model
	Section 
	{
		title: qsTr("Effects")
		columns: 1
		visible: modelOrientation.value == "tieOriented" && eventDirection.value == "undirected"

		VariablesForm
		{
			preferredHeight: 100 * preferencesModel.uiScale
			AvailableVariablesList 
			{ 
				name: "possibleEndogenousEffectsTieUndirected"; 
				title: qsTr("Endogenous effects")
				values:
				[
					{ label: qsTr("Degree difference"),							value: "degreeDiff"				},
					{ label: qsTr("Degree maximum"),								value: "degreeMax"				},
					{ label: qsTr("Degree Minimum"),								value: "degreeMin"				},
					{ label: qsTr("Fixed effects for event type"),	value: "FEtype"						},
					{ label: qsTr("Inertia"),												value: "inertia"					},
					{ label: qsTr("Pshift AB-AB"),									value: "psABAB"						},
					{ label: qsTr("Pshift AB-AY"),									value: "psABAY"						},
					{ label: qsTr("Shared partners"),								value: "sp"								},
					{ label: qsTr("Unique shared partners"),				value: "spUnique"					},
					{ label: qsTr("Recency continue"),							value: "recencyContinue"	},
					{ label: qsTr("Total degree dyad"),							value: "totaldegreeDyad"	},
					{ label: qsTr("User statistics"),								value: "userStat"					}
				]
			}

			AssignedVariablesList { name: "specifiedEndogenousEffectsTieUndirected"}

		}

		DropDown
		{
			id: exDropTieUndir
			name: "exogenousEffectsTieUndirected"
			label: qsTr("Exogenous effects")
			addEmptyValue: true
			values:
			[
				{ label: qsTr("Average"),			value: "averageEffect"		},
				{ label: qsTr("Difference"),	value: "differenceEffect"	},
				{ label: qsTr("Event"),				value: "eventEffect"			},
				{ label: qsTr("Maximum"),			value: "maximumEffect"		},
				{ label: qsTr("Minimum"),			value: "minimumEffect"		},
				{ label: qsTr("Same"),				value: "sameEffect"				},
				{ label: qsTr("Tie"),					value: "tieEffect"				}
			]
		}

		VariablesForm
		{
			preferredHeight: 200 * preferencesModel.uiScale
			AvailableVariablesList{	name:	"effectsVariablesListTieUndirected"; source: "allVariablesList"}
			
			AssignedVariablesList	
			{	
				name:	"averageEffectBoxTieUndirected"
				title: qsTr("Average effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["averageEffect"].includes(exDropTieUndir.value)
			}
			AssignedVariablesList	
			{	
				name:	"differenceEffectBoxTieUndirected"
				title: qsTr("Difference effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["differenceEffect"].includes(exDropTieUndir.value)
			}
			AssignedVariablesList	
			{	
				name:	"eventEffectBoxTieUndirected"
				title: qsTr("Event effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["eventEffect"].includes(exDropTieUndir.value)
			}
			AssignedVariablesList	
			{	
				name:	"maximumEffectBoxTieUndirected"
				title: qsTr("Maximum effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["maximumEffect"].includes(exDropTieUndir.value)
			}
			AssignedVariablesList	
			{	
				name:	"minimumEffectBoxTieUndirected"
				title: qsTr("Minimum effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["minimumEffect"].includes(exDropTieUndir.value)
			}
			AssignedVariablesList	
			{	
				name:	"sameEffectBoxTieUndirected"
				title: qsTr("Same effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["sameEffect"].includes(exDropTieUndir.value)
			}
			AssignedVariablesList	
			{	
				name:	"tieEffectBoxTieUndirected"
				title: qsTr("Tie effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["tieEffect"].includes(exDropTieUndir.value)
			}
		}

		// Group
		// {
		// 	title: qsTr("Interaction Effects")
		// 	VariablesForm
		// 	{
		// 		preferredHeight: 200 * preferencesModel.uiScale
		// 		AvailableVariablesList
		// 		{	
		// 			name:	"interactionEffectsList"
		// 			source: ["groupEffectVariable", "weekendEffectVariable", "settingEffectVariable", "differenceEffectVariables", "minimumEffectVariables", "maximumEffectVariables"] 
		// 		}
		// 		AssignedVariablesList	
		// 		{
		// 			name:	"interactions"
		// 			title: qsTr("Model interactions")
		// 			listViewType: JASP.Interaction
		// 			addAvailableVariablesToAssigned: false
		// 		}
		// 	}
		// }
	}


 // section visible for the actor-oriented sender model
	Section 
	{
		title: qsTr("Effects Sender Model")
		columns: 1
		visible: modelOrientation.value == "actorOriented"

		VariablesForm
		{
			preferredHeight: 100 * preferencesModel.uiScale
			AvailableVariablesList 
			{ 
				name: "possibleEndogenousEffectsActorSender"; 
				title: qsTr("Endogenous effects")
				values:
				[
					{ label: qsTr("In degree sender"),							value: "indegreeSender"					},
					{ label: qsTr("Out degree sender"),							value: "outdegreeSender"				},
					{ label: qsTr("Recency receive of sender"),			value: "recencyReceiveSender"		},
					{ label: qsTr("Recency send of sender"),				value: "recencySendSender"			},
					{ label: qsTr("Total degree sender"),						value: "totaldegreeSender"			},
					{ label: qsTr("User statistics"),								value: "userStat"								}
				]
			}

			AssignedVariablesList { name: "specifiedEndogenousEffectsActorSender"}

		}

		DropDown
		{
			id: exDropActor
			name: "exogenousEffectsActorSender"
			label: qsTr("Exogenous effects")
			addEmptyValue: true
			values:
			[
				{ label: qsTr("Send"),				value: "sendEffect"				}
			]
		}

		VariablesForm
		{
			preferredHeight: 200 * preferencesModel.uiScale
			AvailableVariablesList{	name:	"effectsVariablesListActorSender"; source: "allVariablesList"}
			
			AssignedVariablesList	
			{	
				name:	"sendEffectBoxActorSender"
				title: qsTr("Send effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["sendEffect"].includes(exDropActor.value)
			}
		}

		// Group
		// {
		// 	title: qsTr("Interaction Effects")
		// 	VariablesForm
		// 	{
		// 		preferredHeight: 200 * preferencesModel.uiScale
		// 		AvailableVariablesList
		// 		{	
		// 			name:	"interactionEffectsList"
		// 			source: ["groupEffectVariable", "weekendEffectVariable", "settingEffectVariable", "differenceEffectVariables", "minimumEffectVariables", "maximumEffectVariables"] 
		// 		}
		// 		AssignedVariablesList	
		// 		{
		// 			name:	"interactions"
		// 			title: qsTr("Model interactions")
		// 			listViewType: JASP.Interaction
		// 			addAvailableVariablesToAssigned: false
		// 		}
		// 	}
		// }
	}
 // section visible for the actor-oriented receiver model
	Section 
	{
		title: qsTr("Effects Receiver Model")
		columns: 1
		visible: modelOrientation.value == "actorOriented"

		VariablesForm
		{
			preferredHeight: 100 * preferencesModel.uiScale
			AvailableVariablesList 
			{ 
				name: "possibleEndogenousEffectsActorReceiver"; 
				title: qsTr("Endogenous effects")
				values:
				[
					{ label: qsTr("In degree receiver"),						value: "indegreeReceiver"				},
					{ label: qsTr("Inertia"),												value: "inertia"					},
					{ label: qsTr("Incoming shared partners"),			value: "isp"										},
					{ label: qsTr("Incoming two-path"),							value: "itp"										},
					{ label: qsTr("Outgoing shared partners"),			value: "osp"										},
					{ label: qsTr("Outgoing two-path"),							value: "otp"										},
					{ label: qsTr("Out deregee receiver"),					value: "outdegreeReceiver"			},
					{ label: qsTr("Recency continue"),							value: "recencyContinue"	},
					{ label: qsTr("Recency receive of receiver"), 	value: "recencyReceiveReceiver"	},
					{ label: qsTr("Recency send of receiver"),			value: "recencySendReceiver"		},
					{ label: qsTr("Reciprocity"),										value: "reciprocity"						},
					{ label: qsTr("Recency rank receive"),					value: "rrankReceive"						},
					{ label: qsTr("Recency rank send"),							value: "rrankSend"							},
					{ label: qsTr("Total degree receiver"),					value: "totaldegreeReceiver"		},
					{ label: qsTr("User statistics"),								value: "userStat"								}
				]
			}

			AssignedVariablesList { name: "specifiedEndogenousEffectsActorReceiver"}

		}

		DropDown
		{
			id: exDropActor
			name: "exogenousEffectsActorReceiver"
			label: qsTr("Exogenous effects")
			addEmptyValue: true
			values:
			[
				{ label: qsTr("Average"),			value: "averageEffect"		},
				{ label: qsTr("Difference"),	value: "differenceEffect"	},
				{ label: qsTr("Receive"),			value: "receiveEffect"		},
				{ label: qsTr("Same"),				value: "sameEffect"				},
				{ label: qsTr("Tie"),					value: "tieEffect"				}
			]
		}

		VariablesForm
		{
			preferredHeight: 200 * preferencesModel.uiScale
			AvailableVariablesList{	name:	"effectsVariablesListActorReceiver"; source: "allVariablesList"}
			
			AssignedVariablesList	
			{	
				name:	"averageEffectBoxActorReceiver"
				title: qsTr("Average effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["averageEffect"].includes(exDropActor.value)
			}
			AssignedVariablesList	
			{	
				name:	"differenceEffectBoxActorReceiver"
				title: qsTr("Difference effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["differenceEffect"].includes(exDropActor.value)
			}
			AssignedVariablesList	
			{	
				name:	"receiveEffectBoxActorReceiver"
				title: qsTr("Receive effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["receiveEffect"].includes(exDropActor.value)
			}
			AssignedVariablesList	
			{	
				name:	"sameEffectBoxActorReceiver"
				title: qsTr("Same effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["sameEffect"].includes(exDropActor.value)
			}
			AssignedVariablesList	
			{	
				name:	"sendEffectBoxActorReceiver"
				title: qsTr("Send effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["sendEffect"].includes(exDropActor.value)
			}
			AssignedVariablesList	
			{	
				name:	"tieEffectBoxActorReceiver"
				title: qsTr("Tie effect")
				suggestedColumns: ["nominal"]
				singleVariable: false
				visible: ["tieEffect"].includes(exDropActor.value)
			}
		}

		// Group
		// {
		// 	title: qsTr("Interaction Effects")
		// 	VariablesForm
		// 	{
		// 		preferredHeight: 200 * preferencesModel.uiScale
		// 		AvailableVariablesList
		// 		{	
		// 			name:	"interactionEffectsList"
		// 			source: ["groupEffectVariable", "weekendEffectVariable", "settingEffectVariable", "differenceEffectVariables", "minimumEffectVariables", "maximumEffectVariables"] 
		// 		}
		// 		AssignedVariablesList	
		// 		{
		// 			name:	"interactions"
		// 			title: qsTr("Model interactions")
		// 			listViewType: JASP.Interaction
		// 			addAvailableVariablesToAssigned: false
		// 		}
		// 	}
		// }
	}

	Section
	{
		title: qsTr("Estimation Options")
	}

}
