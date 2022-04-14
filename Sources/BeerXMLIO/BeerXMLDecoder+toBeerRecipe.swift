//
//  BeerXMLDecoder+toBeerRecipe.swift
//  BeerXMLIO
//
//  Created by Thomas Bonk on 08.04.22.
//  Copyright © 2022 Thomas Bonk <thomas@meandmymac.de>
//
//  Licensed under the Apache License, Version 2.0 (the "License"):
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import AbstractBeerRecipe
import Foundation
import SWXMLHash

extension BeerXMLDecoder {
  
  internal func toBeerRecipe(xml: XMLIndexer) -> [BeerRecipe] {
    var recipes = [BeerRecipe]()
    
    xml["RECIPES"].children.forEach { rcp in
      var recipe = BeerRecipe(
        name: rcp["NAME"].element!.text,
        type: BeerRecipe.RecipeType(rawValue: rcp["TYPE"].element!.text)!)
      
      recipe.version = Int(rcp["VERSION"].element!.text)!
      recipe.style = toStyle(rcp["STYLE"])
      recipe.equipment = toEquipment(rcp["EQUIPMENT"])
      recipe.brewer = rcp["BREWER"].element!.text
      recipe.asstBrewer = rcp["ASST_BREWER"].element?.text
      recipe.batchSize = Float(rcp["BATCH_SIZE"].element!.text)
      recipe.boilSize = Float(rcp["BOIL_SIZE"].element!.text)
      recipe.boilTime = UInt16(rcp["BOIL_TIME"].element!.text)
      recipe.efficiency = toFloat(rcp["EFFICIENCY"].element?.text)
      recipe.hops = toHops(rcp["HOPS"].children)
      // FERMENTABLES
      // MISCS
      // YEASTS
      // WATERS
      // MASH
      recipe.notes = rcp["NOTES"].element?.text
      recipe.tasteNotes = rcp["TASTE_NOTES"].element?.text
      recipe.tasteRating = toFloat(rcp["TASTE_RATING"].element?.text)
      recipe.og = toFloat(rcp["OG"].element?.text)
      recipe.fg = toFloat(rcp["FG"].element?.text)
      recipe.fermentationStages = toUInt8(rcp["FERMENTATION_STAGES"].element?.text)
      recipe.primaryAge = toUInt8(rcp["PRIMARY_AGE"].element?.text)
      recipe.primaryTemp = toUInt8(rcp["PRIMARY_TEMP"].element?.text)
      recipe.secondaryAge = toUInt16(rcp["SECONDARY_AGE"].element?.text)
      recipe.secondaryTemp = toUInt8(rcp["SECONDARY_TEMP"].element?.text)
      recipe.tertiaryAge = toUInt16(rcp["TERTIARY_AGE"].element?.text)
      recipe.tertiaryTemp = toUInt8(rcp["TERTIARY_TEMP"].element?.text)
      recipe.age = toUInt16(rcp["AGE"].element?.text)
      recipe.ageTemp = toUInt8(rcp["AGE_TEMP"].element?.text)
      recipe.date = rcp["DATE"].element?.text
      recipe.carbonation = toFloat(rcp["CARBONATION"].element?.text)
      recipe.forcedCarbonation = rcp["FORCED_CARBONATION"].element?.text == "TRUE" ? true : false
      recipe.primingSugarName = rcp["PRIMING_SUGAR_NAME"].element?.text
      recipe.carbonationTemp = toUInt8(rcp["CARBONATION_TEMP"].element?.text)
      recipe.primingSugarEquiv = toFloat(rcp["PRIMING_SUGAR_EQUIV"].element?.text)
      recipe.kegPrimingFactor = toFloat(rcp["KEG_PRIMING_FACTOR"].element?.text)
        
      recipes.append(recipe)
    }
    
    return recipes
  }
  
  fileprivate func toStyle(_ stl: XMLIndexer) -> BeerRecipe.Style {
    var style = BeerRecipe.Style(name: stl["NAME"].element!.text)
    
    style.category = stl["CATEGORY"].element?.text
    style.version = Int(stl["VERSION"].element!.text)!
    style.categoryNumber = stl["CATEGORY_NUMBER"].element?.text
    style.styleLetter = stl["STYLE_LETTER"].element?.text
    style.styleGuide = stl["STYLE_GUIDE"].element?.text
    style.type = BeerRecipe.Style.StyleType(rawValue: stl["TYPE"].element!.text)
    style.ogMin = toFloat(stl["OG_MIN"].element?.text)
    style.ogMax = toFloat(stl["OG_MAX"].element?.text)
    style.fgMin = toFloat(stl["FG_MIN"].element?.text)
    style.fgMax = toFloat(stl["FG_MAX"].element?.text)
    style.ibuMin = toFloat(stl["IBU_MIN"].element?.text)
    style.ibuMax = toFloat(stl["IBU_MAX"].element?.text)
    style.colorMin = toInt(stl["COLOR_MIN"].element?.text)
    style.colorMax = toInt(stl["COLOR_MAX"].element?.text)
    style.carbMin = toFloat(stl["CARB_MIN"].element?.text)
    style.carbMax = toFloat(stl["CARB_MAX"].element?.text)
    style.abvMin = toFloat(stl["ABV_MIN"].element?.text)
    style.abvMax = toFloat(stl["ABV_MAX"].element?.text)
    style.notes = stl["NOTES"].element?.text
    style.profile = stl["PROFILE"].element?.text
    style.ingredients = stl["INGREDIENTS"].element?.text
    style.examples = stl["EXAMPLES"].element?.text
    
    return style
  }
  
  fileprivate func toEquipment(_ eq: XMLIndexer) -> BeerRecipe.Equipment {
    var equipment = BeerRecipe.Equipment(name: eq["NAME"].element!.text)
    
    equipment.version = Int(eq["VERSION"].element!.text)!
    equipment.boilSize = toFloat(eq["BOIL_SIZE"].element?.text)
    equipment.batchSize = toFloat(eq["BATCH_SIZE"].element?.text)
    equipment.tunVolume = toFloat(eq["TUN_VOLUME"].element?.text)
    equipment.tunWeight = toFloat(eq["TUN_WEIGHT"].element?.text)
    equipment.tunSpecificHeat = toFloat(eq["TUN_SPECIFIC_HEAT"].element?.text)
    equipment.topUpWater = toFloat(eq["TOP_UP_WATER"].element?.text)
    equipment.trubChillerLoss = toFloat(eq["TRUB_CHILLER_LOSS"].element?.text)
    equipment.evapRate = toFloat(eq["EVAP_RATE"].element?.text)
    equipment.boilTime = toUInt16(eq["BOIL_TIME"].element?.text)
    equipment.calcBoilVolume = eq["TOP_UP_WATER"].element?.text == "TRUE" ? true : false;
    equipment.lauterDeadspace = toUInt16(eq["LAUTER_DEADSPACE"].element?.text)
    equipment.topUpKettle = toUInt16(eq["TOP_UP_KETTLE"].element?.text)
    equipment.hopUtilization = toFloat(eq["HOP_UTILIZATION"].element?.text)
    equipment.notes = eq["NOTES"].element?.text
    
    return equipment
  }
  
  fileprivate func toHops(_ hops: [XMLIndexer]) -> [BeerRecipe.Hop] {
    return hops.map { hp in
      var hop = BeerRecipe.Hop(name: hp["NAME"].element!.text)
      
      hop.version = Int(hp["VERSION"].element!.text)!
      hop.alpha = toFloat(hp["ALPHA"].element?.text)
      hop.amount = toFloat(hp["AMMOUNT"].element?.text)
      hop.use = BeerRecipe.Hop.Usage(rawValue: hp["USE"].element!.text)
      hop.time = toUInt16(hp["TIME"].element?.text)
      hop.notes = hp["NOTES"].element?.text
      hop.type = BeerRecipe.Hop.HopType(rawValue: hp["TYPE"].element?.text ?? "")
      hop.form = BeerRecipe.Hop.Form(rawValue: hp["FORM"].element?.text ?? "")
      hop.beta = toFloat(hp["BETA"].element?.text)
      hop.hsi = toFloat(hp["HSI"].element?.text)
      hop.origin = hp["ORIGIN"].element?.text
      hop.substitutes = hp["SUBSTITUTES"].element?.text
      hop.humulene = toFloat(hp["HUMULENE"].element?.text)
      hop.caryophyllene = toFloat(hp["CARYOPHYLLENE"].element?.text)
      hop.cohumulone = toFloat(hp["COHUMULONE"].element?.text)
      hop.myrcene = toFloat(hp["MYRCENE"].element?.text)
      
      return hop
    }
  }
  
  fileprivate func toFloat(_ str: String?) -> Float? {
    guard let s = str else {
      return nil
    }
    
    return Float(s)
  }
  
  fileprivate func toUInt8(_ str: String?) -> UInt8? {
    guard let s = str else {
      return nil
    }
    
    return UInt8(s)
  }
  
  fileprivate func toUInt16(_ str: String?) -> UInt16? {
    guard let s = str else {
      return nil
    }
    
    return UInt16(s)
  }
  
  fileprivate func toInt(_ str: String?) -> Int? {
    guard let s = str else {
      return nil
    }
    
    return Int(s)
  }
}
