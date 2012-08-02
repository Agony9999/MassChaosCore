-- -------------------------------------------------------- 
-- 2012_07_12_00_world_version.sql 
-- -------------------------------------------------------- 
UPDATE `version` SET `db_version`='TDB 335.11.48', `cache_id`=48 LIMIT 1;
 
 
-- -------------------------------------------------------- 
-- 2012_07_13_00_world_spell_proc_event.sql 
-- -------------------------------------------------------- 
UPDATE `spell_proc_event` SET `procFlags` = 16384 WHERE `entry` in (48492,48494,48495);
 
 
-- -------------------------------------------------------- 
-- 2012_07_13_00_world_spell_script_names.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE (`spell_id`='-5570');
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(-5570, 'spell_dru_insect_swarm');
 
 
-- -------------------------------------------------------- 
-- 2012_07_14_00_world_creature_loot_template.sql 
-- -------------------------------------------------------- 
-- Gorilla Fang should always be able to drop (Exodius)
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = ABS(`ChanceOrQuestChance`) WHERE `item`=2799;
-- Update "Count" Ungula's Mandible drop rate does not require quest to drop it starts one (gecko32)
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = ABS(`ChanceOrQuestChance`) WHERE `item`=25459;
-- Tainted Hellboar Meat fix (ZxBiohazardZx)
UPDATE `quest_template` SET `RequiredSourceItemId1`=23270,`RequiredSourceItemCount1`=8 WHERE `Id`=9361;
 
 
-- -------------------------------------------------------- 
-- 2012_07_14_01_world_creature_loot_template.sql 
-- -------------------------------------------------------- 
-- Hellboar shit always drops
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -100 WHERE `item`=23270;

-- update Al'ar loot
SET @gear := 34053; 
SET @talon := 34377; 
SET @Alar := 19514;

DELETE FROM `creature_loot_template` WHERE `entry`=@Alar;
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Alar,29434,100,1,0,2,2), -- Badge of Justice 2x
(@Alar,1,100,1,0,-@gear,3), -- 3x Gear Reference
(@Alar,2,10,1,0,-34052,1), -- Pattern Reference
(@Alar,3,2,1,0,-34052,1); -- extra Pattern Reference (small chance)

DELETE FROM `reference_loot_template` WHERE `entry` IN (@gear,@talon);
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Gear Reference:
(@gear,29918,0,1,1,1,1), -- Mindstorm Wristbands
(@gear,29920,0,1,1,1,1), -- Phoenix-Ring of Rebirth
(@gear,29921,0,1,1,1,1), -- Fire Crest Breastplate
(@gear,29922,0,1,1,1,1), -- Band of Al'ar
(@gear,29923,0,1,1,1,1), -- Talisman of the Sun King
(@gear,29924,0,1,1,1,1), -- Netherbane
(@gear,29925,0,1,1,1,1), -- Phoenix-Wing Cloak
(@gear,29947,0,1,1,1,1), -- Gloves of the Searing Grip
(@gear,29948,0,1,1,1,1), -- Claw of the Phoenix
(@gear,29949,0,1,1,1,1), -- Arcanite Steam-Pistol
(@gear,30447,0,1,1,1,1), -- Tome of Fiery Redemption
(@gear,1,0,1,1,-@talon,1), -- Talonoption
-- either of the claws is selected
(@talon,30448,0,1,1,1,1), -- Talon of Al'ar
(@talon,32944,0,1,1,1,1); -- Talon of the Phoenix
 
 
-- -------------------------------------------------------- 
-- 2012_07_16_00_world_creature_template.sql 
-- -------------------------------------------------------- 
-- Fix the damage for Wretched mobs in Magisters' Terrace
UPDATE `creature_template` SET `dmg_multiplier`=0.6 WHERE `entry` IN (24688, 24689, 24690);
 
 
-- -------------------------------------------------------- 
-- 2012_07_16_01_world_reference_loot_template.sql 
-- -------------------------------------------------------- 
-- manually set the reference% for core doesnt understand how to deal with grouped references (lame)
UPDATE `reference_loot_template` SET `ChanceOrQuestChance`=8.33333333 WHERE `entry`=34053 AND `item`=1;
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_00_world_spelldifficulty_dbc.sql 
-- -------------------------------------------------------- 
UPDATE `spelldifficulty_dbc` SET `spellid0`= 61890 WHERE `id`= 3251 AND `spellid1`= 63498;
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_01_world_conditions.sql 
-- -------------------------------------------------------- 
-- Saronite Mine Slave conditions
SET @QUEST_A := 13300;
SET @QUEST_H := 13302;
SET @GOSSIP  := 10137;

-- Only show gossip if player is on quest Slaves to Saronite
DELETE FROM `conditions` WHERE `SourceGroup`=@GOSSIP AND `ConditionValue1` IN (@QUEST_A,@QUEST_H);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15,@GOSSIP,0,0,0,9,0,@QUEST_A,0,0,0,0,'',"Only show first gossip if player is on quest Slaves to Saronite Alliance"),
(15,@GOSSIP,0,0,1,9,0,@QUEST_H,0,0,0,0,'',"Only show first gossip if player is on quest Slaves to Saronite Horde");
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_02_world_creature_loot_template.sql 
-- -------------------------------------------------------- 
-- Item was added to the wrong NPC
-- Source: http://old.wowhead.com/item=19364
DELETE FROM `creature_loot_template` WHERE `entry` IN (1853, 11583) AND `item`=19364;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(11583, 19364, 10, 1, 0, 1, 1);
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_03_world_gossip.sql 
-- -------------------------------------------------------- 
-- Keristrasza (26206)
UPDATE `creature_template` SET `gossip_menu_id` = 9262 WHERE `entry` = 26206;

DELETE FROM `gossip_menu` WHERE `entry`=9262 AND `text_id`=12576;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES (9262, 12576);

-- from sniff
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9262 AND `id`=0;
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9262 AND `id`=1;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES
(9262, 0, 0, 'I am prepared to face Saragosa!', 1, 3, 0, 0, 0, 0, NULL),
(9262, 1, 0, 'Keristrasa, I am finished here. Please return me to the Transitus Shield.', 1, 3, 0, 0, 0, 0, NULL);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9262 AND `SourceEntry`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9262 AND `SourceEntry`=1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9262, 0, 0, 0, 9, 0, 11957, 0, 0, 0, 0, '', "Only show gossip if player has quest Saragosa's End"),
(15, 9262, 1, 0, 0, 9, 0, 11967, 0, 0, 0, 0, '', "Only show gossip if player has quest Mustering the Reds");
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_04_world_gossip.sql 
-- -------------------------------------------------------- 
-- NPC Cowlen - Missing Gossip Options
SET @NPC := 17311;
DELETE FROM `creature_addon` WHERE `guid`=84415;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(84415,0,0,1,0,0,NULL);
UPDATE `creature_template` SET `gossip_menu_id`=7403, `AIName`='SmartAI' WHERE `entry`=@NPC;
DELETE FROM `gossip_menu` WHERE `entry` IN (7403,7402,7401);
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(7403,8870),
(7402,8871),
(7401,8872);
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (7403,7402,7401) AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(7403,0,0, 'I have not come to kill you, night elf. And the gods did not do this...',1,1,7402,0,0,0, ''),
(7402,0,0, 'I fear that my people are somewhat responsible for this destruction. We are refugees, displaced from our homes by the Burning Legion. This tragedy is a result of our latest evacuation. Our vessel crashed - this debris is a part of that vessel.',1,1,7401,0,0,0, ''),
(7401,0,0, 'We have much in common, night elf. I can''t help but feel that perhaps it was fate that brought us together. Let me help you, Cowlen. Let my people help. We will right the wrongs. This I vow.',1,1,0,0,0,0, '');
DELETE FROM `smart_scripts` WHERE `entryorguid`=@NPC AND `source_type`=0 AND `id` IN (0,1);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@NPC,0,0,1,62,0,100,0,7401,0,0,0,5,18,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Cowlen - On gossip option play emote'),
(@NPC,0,1,0,61,0,100,0,7401,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Cowlen - On gossip option Close Gossip');
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_05_world_script_texts.sql 
-- -------------------------------------------------------- 
-- Fixing wrong text in Trial of the Crusader, Twin Valkyrs
UPDATE `script_texts` SET `content_default`='%s begins to read the spell Twin''s Pact!' WHERE `entry`=-1649043;
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_06_world_gossip.sql 
-- -------------------------------------------------------- 
-- gossip assignation from sniff
UPDATE `creature_template` SET `gossip_menu_id`=4182 WHERE `entry`=1466; -- Gretta Finespindle <Apprentice Leatherworker>
UPDATE `creature_template` SET `gossip_menu_id`=201 WHERE `entry`=3678; -- Muyoh <Disciple of Naralex>
UPDATE `creature_template` SET `gossip_menu_id`=7406 WHERE `entry`=3848; -- Kayneth Stillwind
UPDATE `creature_template` SET `gossip_menu_id`=8851 WHERE `entry`=4979; -- Theramore Guard
UPDATE `creature_template` SET `gossip_menu_id`=4862 WHERE `entry`=6771; -- Ravenholdt Assassin <Assassin's League>
UPDATE `creature_template` SET `gossip_menu_id`=3130 WHERE `entry`=10618; -- Rivern Frostwind <Wintersaber Trainer>
UPDATE `creature_template` SET `gossip_menu_id`=3441 WHERE `entry`=10857; -- Argent Quartermaster Lightspark <The Argent Crusade>
UPDATE `creature_template` SET `gossip_menu_id`=3074 WHERE `entry`=10922; -- Greta Mosshoof <Emerald Circle>
UPDATE `creature_template` SET `gossip_menu_id`=3128 WHERE `entry`=11019; -- Jessir Moonbow
UPDATE `creature_template` SET `gossip_menu_id`=3622 WHERE `entry`=11554; -- Grazle
UPDATE `creature_template` SET `gossip_menu_id`=3602 WHERE `entry`=11609; -- Alexia Ironknife
UPDATE `creature_template` SET `gossip_menu_id`=3963 WHERE `entry`=11626; -- Rigger Gizelton
UPDATE `creature_template` SET `gossip_menu_id`=4003 WHERE `entry`=12245; -- Vendor-Tron 1000
UPDATE `creature_template` SET `gossip_menu_id`=4002 WHERE `entry`=12246; -- Super-Seller 680
UPDATE `creature_template` SET `gossip_menu_id`=4922 WHERE `entry`=13085; -- Myrokos Silentform
UPDATE `creature_template` SET `gossip_menu_id`=6531 WHERE `entry`=15182; -- Vish Kozus <Captain of the Guard>
UPDATE `creature_template` SET `gossip_menu_id`=7326 WHERE `entry`=16817; -- Festival Loremaster
UPDATE `creature_template` SET `gossip_menu_id`=7405 WHERE `entry`=17287; -- Sentinel Luciel Starwhisper <Silverwing Sentinels>
UPDATE `creature_template` SET `gossip_menu_id`=7404 WHERE `entry`=17291; -- Architect Nemos
UPDATE `creature_template` SET `gossip_menu_id`=7407 WHERE `entry`=17303; -- Vindicator Vedaar <Hand of Argus>
UPDATE `creature_template` SET `gossip_menu_id`=8080 WHERE `entry`=17310; -- Gnarl <Ancient of War>
UPDATE `creature_template` SET `gossip_menu_id`=7382 WHERE `entry`=17406; -- Artificer
UPDATE `creature_template` SET `gossip_menu_id`=7735 WHERE `entry`=18538; -- Ishanah <High Priestess of the Aldor>
UPDATE `creature_template` SET `gossip_menu_id`=7734 WHERE `entry`=18596; -- Arcanist Adyria <The Scryers>
UPDATE `creature_template` SET `gossip_menu_id`=7747 WHERE `entry`=18653; -- Seth
UPDATE `creature_template` SET `gossip_menu_id`=10459 WHERE `entry`=33746; -- Silvermoon Champion
UPDATE `creature_template` SET `gossip_menu_id`=10461 WHERE `entry`=33748; -- Thunder Bluff Champion
UPDATE `creature_template` SET `gossip_menu_id`=10462 WHERE `entry`=33749; -- Undercity Champion

-- gossip from sniff
DELETE FROM `gossip_menu` WHERE (`entry`=201 AND `text_id`=698) OR (`entry`=3074 AND `text_id`=3807) OR (`entry`=3128 AND `text_id`=3864) OR (`entry`=3130 AND `text_id`=3854) OR (`entry`=3441 AND `text_id`=4193) OR (`entry`=3602 AND `text_id`=4354) OR (`entry`=3621 AND `text_id`=4394) OR (`entry`=3622 AND `text_id`=4393) OR (`entry`=3961 AND `text_id`=4813) OR (`entry`=3963 AND `text_id`=4815) OR (`entry`=4002 AND `text_id`=4856) OR (`entry`=4003 AND `text_id`=4857) OR (`entry`=4182 AND `text_id`=5276) OR (`entry`=4862 AND `text_id`=5938) OR (`entry`=4922 AND `text_id`=5981) OR (`entry`=6531 AND `text_id`=7733) OR (`entry`=6588 AND `text_id`=7801) OR (`entry`=6587 AND `text_id`=7802) OR (`entry`=6586 AND `text_id`=7803) OR (`entry`=6585 AND `text_id`=7804) OR (`entry`=7326 AND `text_id`=8703) OR (`entry`=7382 AND `text_id`=8838) OR (`entry`=7404 AND `text_id`=8873) OR (`entry`=7405 AND `text_id`=8874) OR (`entry`=7406 AND `text_id`=8875) OR (`entry`=7407 AND `text_id`=8876) OR (`entry`=7735 AND `text_id`=9457) OR (`entry`=7734 AND `text_id`=9452) OR (`entry`=7747 AND `text_id`=9486) OR (`entry`=8080 AND `text_id`=9986) OR (`entry`=8464 AND `text_id`=10573) OR (`entry`=8851 AND `text_id`=11492) OR (`entry`=10933 AND `text_id`=15194);
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(201, 698), -- 3678
(3074, 3807), -- 10922
(3128, 3864), -- 11019
(3130, 3854), -- 10618
(3441, 4193), -- 10857
(3602, 4354), -- 11609
(3621, 4394), -- 11554
(3622, 4393), -- 11554
(3961, 4813), -- 11625
(3963, 4815), -- 11626
(4002, 4856), -- 12246
(4003, 4857), -- 12245
(4182, 5276), -- 1466
(4862, 5938), -- 6771
(4922, 5981), -- 13085
(6531, 7733), -- 15182
(6588, 7801), -- 15169
(6587, 7802), -- 15169
(6586, 7803), -- 15169
(6585, 7804), -- 15169
(7326, 8703), -- 16817
(7382, 8838), -- 17406
(7404, 8873), -- 17291
(7405, 8874), -- 17287
(7406, 8875), -- 3848
(7407, 8876), -- 17303
(7735, 9457), -- 18538
(7734, 9452), -- 18596
(7747, 9486), -- 18653
(8080, 9986), -- 17310
(8464, 10573), -- 185126
(8851, 11492), -- 4979
(10933, 15194); -- 37200

-- correct npc_flags for npc from sniff
UPDATE `creature_template` SET `npcflag`=0 WHERE `entry`=8151; -- Nijel's Point Guard
UPDATE `creature_template` SET `npcflag`=2 WHERE `entry`=24393; -- The Rokk <Master of Cooking>
UPDATE `creature_template` SET `npcflag`=1 WHERE `entry`=37119; -- Highlord Tirion Fordring

-- missing gossip from sniff
DELETE FROM `gossip_menu_option` WHERE (`menu_id`=3622 AND `id`=0) OR (`menu_id`=4002 AND `id`=0) OR (`menu_id`=4003 AND `id`=0) OR (`menu_id`=6586 AND `id`=0) OR (`menu_id`=6587 AND `id`=0) OR (`menu_id`=6588 AND `id`=0) OR (`menu_id`=10456 AND `id`=0) OR (`menu_id`=10457 AND `id`=0) OR (`menu_id`=10461 AND `id`=0) OR (`menu_id`=10462 AND `id`=0);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES
(3622, 0, 0, 'How can I prove myself to the Timbermaw furbolg?', 1, 3, 3621, 0, 0, 0, ''), -- 11554
(4002, 0, 1, 'Let me take a look at what you have to offer.', 3, 387, 0, 0, 0, 0, ''), -- 12246
(4003, 0, 1, 'I am curious to see what a bucket of bolts has to offer.', 3, 131, 0, 0, 0, 0, ''), -- 12245
(6586, 0, 0, 'And what do you say?', 1, 1, 6585, 0, 0, 0, ''), -- 15169
(6587, 0, 0, 'What do they say?', 1, 1, 6586, 0, 0, 0, ''), -- 15169
(6588, 0, 0, 'How do you know?', 1, 1, 6587, 0, 0, 0, ''), -- 15169
(10456, 0, 0, 'I am ready to fight!', 1, 1, 0, 0, 0, 0, ''), -- 33743
(10457, 0, 0, 'I am ready to fight!', 1, 1, 0, 0, 0, 0, ''), -- 33744
(10461, 0, 0, 'I am ready to fight!', 1, 1, 0, 0, 0, 0, ''), -- 33748
(10462, 0, 0, 'I am ready to fight!', 1, 1, 0, 0, 0, 0, ''); -- 33749
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_07_world_sai.sql 
-- -------------------------------------------------------- 
-- Add SAI for Liquid Pyrite ID: 33189 - remove auras to prevent exploit after used, also despawn
SET @Pyrite := 33189;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@Pyrite;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@Pyrite;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@Pyrite,0,0,1,8,0,100,0,67390,0,0,0,28,62494,0,0,0,0,0,1,0,0,0,0,0,0,0,'Pyrite - On hit by spell Ride Vehicle - Remove auras from Liquid Pyrite'),
(@Pyrite,0,1,0,61,0,100,0,0,0,0,0,41,15000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Pyrite - Linked with previous event - Despawn in 15 sec');
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_08_world_sai.sql 
-- -------------------------------------------------------- 
-- Remove disables (instances scripts) for 10 and 25 version of achievement Dwarfageddon
DELETE FROM `achievement_criteria_data` WHERE  `criteria_id`=10858 AND `type`=18;
DELETE FROM `achievement_criteria_data` WHERE  `criteria_id`=10860 AND `type`=18;
-- Insert the required spell credit markers for Dwarfageddon (10/25 player) achievements
DELETE FROM `spell_dbc` WHERE `Id`=65387;
INSERT INTO `spell_dbc` (`Id`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `AttributesEx6`, `AttributesEx7`, `Stances`, `StancesNot`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcFlags`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `Effect1`, `Effect2`, `Effect3`, `EffectDieSides1`, `EffectDieSides2`, `EffectDieSides3`, `EffectRealPointsPerLevel1`, `EffectRealPointsPerLevel2`, `EffectRealPointsPerLevel3`, `EffectBasePoints1`, `EffectBasePoints2`, `EffectBasePoints3`, `EffectMechanic1`, `EffectMechanic2`, `EffectMechanic3`, `EffectImplicitTargetA1`, `EffectImplicitTargetA2`, `EffectImplicitTargetA3`, `EffectImplicitTargetB1`, `EffectImplicitTargetB2`, `EffectImplicitTargetB3`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectRadiusIndex3`, `EffectApplyAuraName1`, `EffectApplyAuraName2`, `EffectApplyAuraName3`, `EffectAmplitude1`, `EffectAmplitude2`, `EffectAmplitude3`, `EffectMultipleValue1`, `EffectMultipleValue2`, `EffectMultipleValue3`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectMiscValue3`, `EffectMiscValueB1`, `EffectMiscValueB2`, `EffectMiscValueB3`, `EffectTriggerSpell1`, `EffectTriggerSpell2`, `EffectTriggerSpell3`, `EffectSpellClassMaskA1`, `EffectSpellClassMaskA2`, `EffectSpellClassMaskA3`, `EffectSpellClassMaskB1`, `EffectSpellClassMaskB2`, `EffectSpellClassMaskB3`, `EffectSpellClassMaskC1`, `EffectSpellClassMaskC2`, `EffectSpellClassMaskC3`, `MaxTargetLevel`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `MaxAffectedTargets`, `DmgClass`, `PreventionType`, `DmgMultiplier1`, `DmgMultiplier2`, `DmgMultiplier3`, `AreaGroupId`, `SchoolMask`, `Comment`) VALUES
(65387, 0, 0, 545259776, 0, 5, 268697600, 128, 0, 16777216, 0, 0, 0, 0, 1, 0, 0, 101, 0, 0, 0, 0, 0, 13, 0, -1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 7, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 'Steelforged Defender - Credit marker');
-- Add SAI support for Dwarfageddon (10 and 25 player) achievement/also SAI for the NPC connected
SET @Defender := 33236;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@Defender;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@Defender;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@Defender,0,0,0,6,0,100,0,0,0,0,0,11,65387,0,0,0,0,0,16,0,0,0,0,0,0,0,'Steelforged Defender - On death - Cast achievement credit'),
(@Defender,0,1,0,0,0,100,0,0,2500,9000,12000,11,62845,0,0,0,0,0,2,0,0,0,0,0,0,0,'Steelforged Defender - IC - Hamstring'),
(@Defender,0,2,0,0,0,100,0,0,2600,13000,14000,11,50370,0,0,0,0,0,2,0,0,0,0,0,0,0,'Steelforged Defender - IC - Cast Sunder armor'),
(@Defender,0,3,0,0,0,100,0,500,4000,4500,9000,11,57780,0,0,0,0,0,2,0,0,0,0,0,0,0,'Steelforged Defender - IC - Cast Lightening Bolt');
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_09_world_creature_template.sql 
-- -------------------------------------------------------- 
-- Add spells to Salvaged Chopper - 25 version
UPDATE `creature_template` SET `spell1`=62974,`spell2`=62286,`spell3`=62299,`spell4`=64660, `mechanic_immune_mask`=344276858 WHERE `entry`=34045;
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_10_world_creature_onkill_rep.sql 
-- -------------------------------------------------------- 
-- Critter Fire Beetle should not give reputation with Honor Hold when killed
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 9699;
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_11_world_conditions.sql 
-- -------------------------------------------------------- 
-- Exarch Menelaous - Missing condition for gossip 7370
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=7370 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,7370,0,0,0,9,9456,0,0,0,0,'','Exarch Menelaous - Show gossip option if player has quest 9456');
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_12_world_creature_template.sql 
-- -------------------------------------------------------- 
-- Fix Night Elf Corpse (16804) so it can't be attacked
UPDATE `creature_template` SET `unit_flags`=768, `dynamicflags`=40 WHERE `entry` = 16804;
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_13_world_conditions.sql 
-- -------------------------------------------------------- 
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=160445;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(22, 1, 160445, 1, 0, 28, 0, 3821, 0, 0, 0, 0, '', 'Execute SmartAI for gameobject 160445 only if player has complete quest 3821');
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_14_world_gameobject.sql 
-- -------------------------------------------------------- 
-- GO missing spawn
-- Zone: Tanaris, Area: Land's End Beach or Finisterrae Beach
SET @GO_ENTRY := 142189; -- GO Inconspicuous Landmark entry
SET @GO_GUID := 329; -- Need one guid
SET @POOL := 355; -- Need one entry

DELETE FROM `gameobject` WHERE `id`=@GO_ENTRY;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(17499,@GO_ENTRY,1,1,1,-10249.2,-3981.8,1.66783,-0.750491,0,0,0.366501,-0.930418,900,100,1), -- Already in TDB
(17498,@GO_ENTRY,1,1,1,-10119.7,-4052.46,5.33005,-0.366519,0,0,0.182236,-0.983255,900,100,1), -- Already in TDB
(@GO_GUID,@GO_ENTRY,1,1,1,-10154.2,-3948.635,7.744733,2.652894,0,0,0.970295,0.241925,900,100,1);

DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(@POOL,1 , 'GO Inconspicuous Landmark (142189)');

DELETE FROM `pool_gameobject` WHERE `guid` IN (17498,17499,@GO_GUID);
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(17498,@POOL,0, 'Inconspicuous Landmark'),
(17499,@POOL,0, 'Inconspicuous Landmark'),
(@GO_GUID,@POOL,0, 'Inconspicuous Landmark');
 
 
-- -------------------------------------------------------- 
-- 2012_07_22_15_world_sai.sql 
-- -------------------------------------------------------- 
-- SAI for quest 12150 "Reclusive Runemaster"
SET @Dregmar := 27003;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@Dregmar;
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry`=@Dregmar;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@Dregmar AND `source_type`=0 AND `id` BETWEEN 0 AND 2;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@Dregmar*100 AND `source_type`=9 AND `id` BETWEEN 0 AND 8;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@Dregmar,0,0,0,4,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Dregmar Runebrand - on aggro - yell text 0'),
(@Dregmar,0,1,0,2,0,100,1,0,50,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Dregmar Runebrand - at 50% HP - yell text 1'),
(@Dregmar,0,2,0,2,0,100,0,0,20,0,0,80,@Dregmar*100,2,0,0,0,0,1,0,0,0,0,0,0,0, 'Dregmar Runebrand - at 20% HP - run script'),
(@Dregmar*100,9,0,0,0,0,100,0,0,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Dregmar Runebrand - set phase 1'),
(@Dregmar*100,9,1,0,0,0,100,0,0,0,0,0,24,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Dregmar Runebrand - evade'),
(@Dregmar*100,9,2,0,0,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Dregmar Runebrand - Stop combat'),
(@Dregmar*100,9,3,0,0,0,100,0,0,0,0,0,18,33346,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Dregmar Runebrand - unitflags OutOfCombat'),
(@Dregmar*100,9,4,0,0,0,100,0,0,0,0,0,75,48325,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Dregmar Runebrand - apply aura RUNE SHIELD'),
(@Dregmar*100,9,5,0,0,0,100,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Dregmar Runebrand - yell text 2'),
(@Dregmar*100,9,6,0,0,0,100,0,0,14000,0,0,11,48028,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Dregmar Runebrand - Complete quest on player range'),
(@Dregmar*100,9,7,0,0,0,100,0,0,14000,0,0,19,514,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Dregmar Runebrand - unitflags reseted'),
(@Dregmar*100,9,8,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Dregmar Runebrand - force despawn');

-- creature_text
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -894 AND -892;
DELETE FROM `creature_text` WHERE `entry`=@Dregmar AND `groupid` BETWEEN 0 AND 2;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@Dregmar,0,0, 'I know why you''ve come - one of those foolish Magnataur on the plains meddled and managed to get the dragons involved. Do you enjoy serving them like a dog?',14,0,100,0,0,0, 'Dregmar Runebrand - yell'),
(@Dregmar,1,0, 'You seek their leader... little thing, you wage war against the clans of Grom''thar the Thunderbringer himself. Don''t be so eager to rush to your death.',14,0,100,0,0,0, 'Dregmar Runebrand yell'),
(@Dregmar,2,0, 'Hah! So be it. Blow the horn of a magnataur leader at the ring of torches south of the Azure Dragonshrine. Make peace with your gods... Grom''thar will come.',14,0,100,0,0,0, 'Dregmar Runebrand yell');
 
 
-- -------------------------------------------------------- 
-- 2012_07_29_00_world_factionchange.sql 
-- -------------------------------------------------------- 
-- Faction change item conversion for Reins of the Traveler's Tundra Mammoth
DELETE FROM `player_factionchange_items` WHERE `alliance_id`=44235;
INSERT INTO `player_factionchange_items` (`race_A`, `alliance_id`, `commentA`, `race_H`, `horde_id`, `commentH`) VALUES
(0,44235,'Reins of the Traveler''s Tundra Mammoth',0,44234,'Reins of the Traveler''s Tundra Mammoth');

-- Faction change spell conversion for Reins of the Traveler's Tundra Mammoth
DELETE FROM `player_factionchange_spells` WHERE `alliance_id`=61425;
INSERT INTO `player_factionchange_spells` (`alliance_id`,`horde_id`) VALUES
(61425,61447);
 
 
-- -------------------------------------------------------- 
-- 2012_07_29_01_world_pool_quest.sql 
-- -------------------------------------------------------- 
SET @pool_id := 356;

DELETE FROM `pool_template` WHERE `entry` IN (@pool_id, @pool_id+1);
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(@pool_id,1,'Wind Trader Zhareem - Daily Quests'),
(@pool_id+1,1,'Nether-Stalker Mah''duun - Daily Quests');

DELETE FROM `pool_quest` WHERE `entry` IN (11369,11384,11382,11363,11362,11375,11354,11386,11373,11378,11374,11372,11368,11388,11499,11370) AND `pool_entry` = @pool_id;
DELETE FROM `pool_quest` WHERE `entry` IN (11389,11371,11376,11383,11364,11500,11385,11387) AND `pool_entry` = @pool_id+1;
INSERT INTO `pool_quest` (`entry`,`pool_entry`,`description`) VALUES
(11369,@pool_id,'Wanted: A Black Stalker Egg'),
(11384,@pool_id,'Wanted: A Warp Splinter Clipping'),
(11382,@pool_id,'Wanted: Aeonus''s Hourglass'),
(11363,@pool_id,'Wanted: Bladefist''s Seal'),
(11362,@pool_id,'Wanted: Keli''dan''s Feathered Stave'),
(11375,@pool_id,'Wanted: Murmur''s Whisper'),
(11354,@pool_id,'Wanted: Nazan''s Riding Crop'),
(11386,@pool_id,'Wanted: Pathaleon''s Projector'),
(11373,@pool_id,'Wanted: Shaffar''s Wondrous Pendant'),
(11378,@pool_id,'Wanted: The Epoch Hunter''s Head'),
(11374,@pool_id,'Wanted: The Exarch''s Soul Gem'),
(11372,@pool_id,'Wanted: The Headfeathers of Ikiss'),
(11368,@pool_id,'Wanted: The Heart of Quagmirran'),
(11388,@pool_id,'Wanted: The Scroll of Skyriss'),
(11499,@pool_id,'Wanted: The Signet Ring of Prince Kael''thas'),
(11370,@pool_id,'Wanted: The Warlord''s Treatise'),
(11389,@pool_id+1,'Wanted: Arcatraz Sentinels'),
(11371,@pool_id+1,'Wanted: Coilfang Myrmidons'),
(11376,@pool_id+1,'Wanted: Malicious Instructors'),
(11383,@pool_id+1,'Wanted: Rift Lords'),
(11364,@pool_id+1,'Wanted: Shattered Hand Centurions'),
(11500,@pool_id+1,'Wanted: Sisters of Torment'),
(11385,@pool_id+1,'Wanted: Sunseeker Channelers'),
(11387,@pool_id+1,'Wanted: Tempest-Forge Destroyers');
 
 
-- -------------------------------------------------------- 
-- 2012_07_29_02_world_sai.sql 
-- -------------------------------------------------------- 
SET @Gossip :=9640;
SET @NPCText :=13047;

DELETE FROM `gossip_menu` WHERE `entry` = @Gossip;
INSERT INTO `gossip_menu` VALUES
(@Gossip,@NPCText);

DELETE FROM `gossip_menu_option` WHERE `menu_id` = @Gossip;
INSERT INTO `gossip_menu_option` VALUES
(@Gossip,0,0,"Soldier, you have new orders. You're to pull back and report to the sergeant!",1,1,0,0,0,0,NULL);

UPDATE `creature_template` SET `gossip_menu_id` = @Gossip, AIName = 'SmartAI', `npcflag` = `npcflag`|1 WHERE `entry` = 28041;

DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 28041;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 28041 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 28041*100 AND `source_type` = 9;
INSERT INTO `smart_scripts` VALUES
(28041,0,0,0,0,0,100,0,8000,10000,8000,12000,11,50370,0,0,0,0,0,2,0,0,0,0,0,0,0,'Argent Soldier - Combat - Cast Sunder Armor'),
(28041,0,1,2,62,0,100,0,@Gossip,0,0,0,33,28041,0,0,0,0,0,7,0,0,0,0,0,0,0,'Argent Soldier - On Gossip - Credit'),
(28041,0,2,3,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Argent Soldier - Event Linked - Close Gossip'),
(28041,0,3,4,61,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Soldier - Event Linked - NpcFlag Remove'),
(28041,0,4,0,61,0,100,0,0,0,0,0,80,2804100,0,2,0,0,0,1,0,0,0,0,0,0,0,'Argent Soldier - Event Linked - Run Script'),
(28041*100,9,0,0,0,0,100,0,6000,6000,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Soldier - Script 6 Seconds - Unseen'),
(28041*100,9,1,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Soldier - Script - Despawn');

DELETE FROM `conditions` WHERE SourceTypeOrReferenceId= 15  AND SourceGroup=@Gossip;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, @Gossip, 0, 0, 0, 9, 0, 12504, 0, 0, 0, 0, '', NULL);
 
 
-- -------------------------------------------------------- 
-- 2012_07_29_03_world_sai.sql 
-- -------------------------------------------------------- 
-- [Q] Truce (11989)
SET @ENTRY := 26423; -- Drakuru
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 1, 62, 0, 100, 0, 9615, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Drakuru - On Gossip Select - Close Gossip'),
(@ENTRY, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 85, 50016, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Drakuru - On Gossip Select - Give kill credit');
 
 
-- -------------------------------------------------------- 
-- 2012_07_29_04_world_sai.sql 
-- -------------------------------------------------------- 
UPDATE `creature` SET `spawntimesecs`=180 WHERE `id`=23689;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (23689,24170);

DELETE FROM `creature_ai_scripts` WHERE `creature_id`=23689;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (23689,24170) AND `source_type`=0;
insert into `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) values
(23689,0,1,2,65,0,100,0,0,0,0,0,11,36809,2,0,0,0,0,1,0,0,0,0,0,0,0,'Proto-Drake - Reach Target - Cast Spell (36809)'),
(23689,0,2,0,61,0,100,0,0,0,0,0,33,24170,0,0,0,0,0,18,35,0,0,0,0,0,0,'Draconis Gastritis Bunny - On Death - Quest Reward'),
(23689,0,3,5,1,0,100,0,10000,10000,10000,10000,29,0,0,24170,1,1,0,19,24170,75,0,0,0,0,0,'Proto-Drake - Find Target - Follow'),
(23689,0,4,0,65,0,100,0,0,0,0,0,51,0,0,0,0,0,0,19,24170,5,0,0,0,0,0,'Proto-Drake - Reach Target - Kill Dummy'),
(23689,0,5,3,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Proto-Drake - On Find Target - Set Phase 1'),
(23689,0,6,0,1,1,100,0,45000,45000,45000,45000,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Proto-Drake - Idle on Ground(Phase 1) - Despawn'),
(24170,0,0,0,54,0,100,0,0,0,0,0,50,186598,60000,0,0,0,0,1,0,0,0,0,0,0,0,'Draconis Gastritis Bunny - On Create - Spawn GO'),
(24170,0,1,0,6,0,100,0,0,0,0,0,33,24170,0,0,0,0,0,18,20,0,0,0,0,0,0,'Draconis Gastritis Bunny - On Death - Quest Reward'),
(24170,0,2,0,54,0,100,0,0,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Draconis Gastritis Bunny - On Create - Hide'),
(24170,0,3,0,6,0,100,0,0,0,0,0,41,0,0,0,0,0,0,15,186598,5,0,0,0,0,0,'Draconis Gastritis Bunny - On Death - Remove Gobjects');
 
 
-- -------------------------------------------------------- 
-- 2012_07_29_05_world_sai.sql 
-- -------------------------------------------------------- 
-- Life or Death (12296)

SET @ENTRY := 27482; -- Wounded Westfall Infantry npc
SET @SOURCETYPE := 0;
SET @CREDIT := 27466; -- Kill Credit Bunny - Wounded Skirmishers npc
SET @ITEM := 37576; -- Renewing Bandage item

DELETE FROM `conditions` WHERE `SourceEntry`=@ITEM;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(18,0,@ITEM,0,24,1,@ENTRY,0,0,'', "Item Renewing Bandage target Wounded Westfall Infantry");

-- Wounded Westfall Infantry SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,@SOURCETYPE,0,0,8,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On creature spellhit - Set phasemask 1 - self"),
(@ENTRY,@SOURCETYPE,1,0,1,1,100,0,0,0,3000,3000,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On OOC - Talk - Self"),
(@ENTRY,@SOURCETYPE,2,3,1,1,100,0,2000,2000,2000,2000,53,1,@ENTRY,0,12296,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On OOC Update 2 sec - Start WP 1 - Self"),
(@ENTRY,@SOURCETYPE,3,4,61,1,100,0,0,0,0,0,18,128,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Link - Set unit_flag 128 - Self"),
(@ENTRY,@SOURCETYPE,4,5,61,1,100,0,0,0,0,0,33,@CREDIT,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Link - Give credit - Invoker"),
(@ENTRY,@SOURCETYPE,5,0,61,1,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Link - Set phasemask 2 - Self"),
(@ENTRY,@SOURCETYPE,6,0,40,2,100,0,2,@ENTRY,0,0,41,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On WP 2 - Force despawn - Self");

DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"I'd nearly given up.You've given me new life!",12,0,50,0,0,0,"Wounded Westfall Infantry say text"),
(@ENTRY,0,1,"Bless you, friend.I nearly expired....",12,0,50,0,0,0,"Wounded Westfall Infantry say text"),
(@ENTRY,0,2,"Without your help, I surely would have died....",12,0,50,0,0,0,"Wounded Westfall Infantry say text"),
(@ENTRY,0,3,"Thank you $r.",12,0,50,0,0,0,"Wounded Westfall Infantry say text");

DELETE FROM `waypoints` WHERE `entry`=@ENTRY;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@ENTRY,1,4105.278809,-2917.963867,280.320129,'Wounded Westfall Infantry'),
(@ENTRY,2,4048.682861,-2936.736572,275.191681,'Wounded Westfall Infantry');
 
 
-- -------------------------------------------------------- 
-- 2012_07_29_06_world_sai.sql 
-- -------------------------------------------------------- 
-- Remove previous fix
DELETE FROM `gossip_menu` WHERE `entry` = 9640;
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 9640;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 28041 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 28041*100 AND `source_type` = 9;
DELETE FROM `conditions` WHERE SourceTypeOrReferenceId= 15  AND SourceGroup = 9640;

-- Argent Crusade, We Are Leaving! (12504)

SET @ENTRY := 28041; -- Argent Soldier
SET @SOURCETYPE := 0;
SET @CREDIT := 50289; -- Argent Crusade, We Are Leaving!: Argent Soldier Quest Credit
SET @MENUID := 9640;
SET @OPTION := 0;

UPDATE `creature_template` SET `gossip_menu_id`=@MENUID,`npcflag`=1,`AIName`='SmartAI' WHERE `entry`=@ENTRY;

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@MENUID AND `id`=@OPTION;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES
(@MENUID,@OPTION,0,"Soldier, you have new orders. You're to pull back and report to the sergeant!",1,1,0,0,0,0,'');

DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY,@SOURCETYPE,0,0,0,0,100,0,8000,10000,8000,12000,11,50370,0,0,0,0,0,2,0,0,0,0,0,0,0,"IC - Cast Sunder Armor - Victim"),
(@ENTRY,@SOURCETYPE,1,2,62,0,100,0,@MENUID,@OPTION,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"On gossip select - Close Gossip - Invoker"),
(@ENTRY,@SOURCETYPE,2,3,61,0,100,0,0,0,0,0,11,@CREDIT,0,0,0,0,0,7,0,0,0,0,0,0,0,"On link - Cast credit spell - Invoker"),
(@ENTRY,@SOURCETYPE,3,4,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"On link - Whisper - Invoker"),
(@ENTRY,@SOURCETYPE,4,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"On link - Despawn - Self");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@MENUID AND `SourceEntry`=@OPTION;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,@MENUID,@OPTION,2,9,12504,0,0,0,'',"Show gossip option 0 if player has quest 12504 marked as taken");

DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Careful here, $C. These trolls killed their own snake god!",15,0,50,0,0,0,"Argent Soldier whisper text"),
(@ENTRY,0,1,"Watch your back. These Drakkari are a nasty lot.",15,0,50,0,0,0,"Argent Soldier whisper text"),
(@ENTRY,0,2,"These Drakkari are just bad news. We need to leave and head back to Justice Keep!",15,0,50,0,0,0,"Argent Soldier whisper text"),
(@ENTRY,0,3,"See you around.",15,0,50,0,0,0,"Argent Soldier whisper text"),
(@ENTRY,0,4,"I wonder where we're headed to. And who's going to deal with these guys?",15,0,50,0,0,0,"Argent Soldier whisper text"),
(@ENTRY,0,5,"Right. I'd better get back to the sergeant then.",15,0,50,0,0,0,"Argent Soldier whisper text"),
(@ENTRY,0,6,"Are you $N? I heard you were dead.",15,0,50,0,0,0,"Argent Soldier whisper text");
 
 
-- -------------------------------------------------------- 
-- 2012_07_29_07_world_sai.sql 
-- -------------------------------------------------------- 
DELETE FROM `smart_scripts` WHERE `entryorguid`=181758 AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(181758, 1, 0, 0, 20,  0, 100, 0, 9561, 0, 0, 0, 56, 23846, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Add Nolkais Box after finishing quest: Nolkais Words');
UPDATE `gameobject_template` SET `AIName`= 'SmartGameObjectAI' WHERE `entry`=181758;
 
 
-- -------------------------------------------------------- 
-- 2012_07_29_08_world_sai.sql 
-- -------------------------------------------------------- 
-- Meeting at the Blackwing Coven quest fix

-- Variables
SET @QUEST := 10722;
SET @ENTRY := 22019;
SET @SPELL1:= 37704; -- Whirlwind
SET @SPELL2:= 8599; -- Enrage

-- Add SmartAI for Kolphis Darkscale
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY; 
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,8439,0,0,0,15,@QUEST,0,0,0,0,0,7,0,0,0,0,0,0,0,'Kolphis Darkscale - On Gossip Select - Quest Credit'),
(@ENTRY,0,1,0,0,0,50,0,3000,3000,8000,8000,11,@SPELL1,0,0,0,0,0,2,0,0,0,0,0,0,0,'Kolphis Darkscale - Combat - Whirlwind'),
(@ENTRY,0,2,3,2,0,100,1,0,25,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Kolphis Darkscale - On Health level - Emote when below 25% HP'),
(@ENTRY,0,3,0,61,0,100,1,0,0,0,0,11,@SPELL2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Kolphis Darkscale - On Health level - Cast Enrage when below 25% HP');

-- add missing text to Kolphis Darkscale from sniff
DELETE FROM `npc_text` WHERE `ID`=10540;
INSERT INTO `npc_text` (`ID`,`prob0`,`text0_0`,`text0_1`,`WDBVerified`) VALUES
(10540,1,"Begone, overseer!  We've already spoken.$B$BStop dragging your feet and execute your orders at Ruuan Weald!",'',1);

-- Kolphis Darkscale emote
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,'%s becomes enraged!',16,0,100,0,0,0,'Kolphis Darkscale');

-- Gossip menu insert from sniff
DELETE FROM `gossip_menu` WHERE `entry`=8436 AND `text_id`=10540;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (8436,10540);

-- Add gossip_menu conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=8436;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15,8436,0,0,0,9,0,@QUEST,0,0,0,0,'','Kolphis Darkscale - Show Gossip Option 0 - If on Quest Meeting at the Blackwing Coven'),
(14,8436,10540,0,0,28,0,@QUEST,0,0,0,0,'','Kolphis Darkscale - Show Gossip Menu - If Quest Meeting at the Blackwing Coven is Completed');
 
 
-- -------------------------------------------------------- 
-- 2012_07_29_09_world_gossip_menu_option.sql 
-- -------------------------------------------------------- 
UPDATE `gossip_menu_option` SET
	`npc_option_npcflag` = 65536,
    `option_icon` = 5
WHERE
	`menu_id` = 1293 AND
	`id` = 1;

UPDATE `gossip_menu_option` SET
	`npc_option_npcflag` = 128
WHERE
	`menu_id` = 1293 AND 
	`id` = 2;
 
 
-- -------------------------------------------------------- 
-- 2012_07_29_10_world_sai.sql 
-- -------------------------------------------------------- 
-- [Q] Measuring Warp Energies

DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN(20333,20336,20337,20338);
UPDATE `creature_template` SET AIName='SmartAI' WHERE `entry` IN (20333,20336,20337,20338);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (20333,20336,20337,20338);
INSERT INTO `smart_scripts` VALUES
(20333,0,0,0,8,0,100,0,35113,0,0,0,33,20333,0,0,0,0,0,7,0,0,0,0,0,0,0,"Northern Pipe Credit Marker - Spellhit - Credit"),
(20336,0,0,0,8,0,100,0,35113,0,0,0,33,20336,0,0,0,0,0,7,0,0,0,0,0,0,0,"Eastern Pipe Credit Marker - Spellhit - Credit"),
(20337,0,0,0,8,0,100,0,35113,0,0,0,33,20337,0,0,0,0,0,7,0,0,0,0,0,0,0,"Southern Pipe Credit Marker - Spellhit - Credit"),
(20338,0,0,0,8,0,100,0,35113,0,0,0,33,20338,0,0,0,0,0,7,0,0,0,0,0,0,0,"Western Pipe Credit Marker - Spellhit - Credit");

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=35113;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 35113, 0, 0, 31, 0, 3, 20333, 0, 0, 0, '', "Spell Search NPC 20333"),
(13, 1, 35113, 0, 1, 31, 0, 3, 20336, 0, 0, 0, '', "Spell Search NPC 20336"),
(13, 1, 35113, 0, 2, 31, 0, 3, 20337, 0, 0, 0, '', "Spell Search NPC 20337"),
(13, 1, 35113, 0, 3, 31, 0, 3, 20338, 0, 0, 0, '', "Spell Search NPC 20338");

UPDATE `creature` SET `position_x`=3214.92, `position_y`=4065.25, `position_z`=106.16 WHERE `id`=20333;
UPDATE `creature` SET `position_x`=2755.55, `position_y`=3863.32, `position_z`=142.27 WHERE `id`=20336;
UPDATE `creature` SET `position_x`=2819.01, `position_y`=4351.10, `position_z`=144.97 WHERE `id`=20337;
UPDATE `creature` SET `position_x`=2947.31, `position_y`=4327.47, `position_z`=154.02 WHERE `id`=20338;
 
 
-- -------------------------------------------------------- 
-- _MERGED.sql 
-- -------------------------------------------------------- 
 
 
