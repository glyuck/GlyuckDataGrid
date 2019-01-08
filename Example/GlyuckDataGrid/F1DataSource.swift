//
//  F1DataSource.swift
//
//  Created by Vladimir Lyukov on 14/08/15.
//

import Foundation
import UIKit


class F1DataSource: NSObject {
    @objc static let stats:[[String:String]] = [
        ["season": "1950", "driver": "Giuseppe Farina", "age": "44", "team": "Alfa Romeo", "engine": "Alfa Romeo", "poles": "2", "wins": "3", "podiums": "3", "fastest_laps": "3", "points": "30", "clinched": "Race 7 of 7", "point_margin": "3"],
        ["season": "1951", "driver": "Juan Manuel Fangio", "age": "40", "team": "Alfa Romeo", "engine": "Alfa Romeo", "poles": "4", "wins": "3", "podiums": "5", "fastest_laps": "5", "points": "31", "clinched": "Race 8 of 8", "point_margin": "6"],
        ["season": "1952", "driver": "Alberto Ascari", "age": "34", "team": "Ferrari", "engine": "Ferrari", "poles": "5", "wins": "6", "podiums": "6", "fastest_laps": "6", "points": "36", "clinched": "Race 6 of 8", "point_margin": "12"],
        ["season": "1953", "driver": "Alberto Ascari", "age": "35", "team": "Ferrari", "engine": "Ferrari", "poles": "6", "wins": "5", "podiums": "5", "fastest_laps": "4", "points": "34.5", "clinched": "Race 8 of 9", "point_margin": "6.5"],
        ["season": "1954", "driver": "Juan Manuel Fangio", "age": "43", "team": "Maserati2", "engine": "Maserati", "poles": "5", "wins": "6", "podiums": "7", "fastest_laps": "3", "points": "42", "clinched": "Race 7 of 9", "point_margin": "16.86"],
        ["season": "1955", "driver": "Juan Manuel Fangio", "age": "44", "team": "Mercedes", "engine": "Mercedes", "poles": "3", "wins": "4", "podiums": "5", "fastest_laps": "3", "points": "40", "clinched": "Race 6 of 7", "point_margin": "16.5"],
        ["season": "1956", "driver": "Juan Manuel Fangio", "age": "45", "team": "Ferrari", "engine": "Ferrari", "poles": "6", "wins": "3", "podiums": "5", "fastest_laps": "4", "points": "30", "clinched": "Race 8 of 8", "point_margin": "3"],
        ["season": "1957", "driver": "Juan Manuel Fangio", "age": "46", "team": "Maserati", "engine": "Maserati", "poles": "4", "wins": "4", "podiums": "6", "fastest_laps": "2", "points": "40", "clinched": "Race 6 of 8", "point_margin": "15"],
        ["season": "1958", "driver": "Mike Hawthorn", "age": "29", "team": "Ferrari", "engine": "Ferrari", "poles": "4", "wins": "1", "podiums": "7", "fastest_laps": "5", "points": "42", "clinched": "Race 11 of 11", "point_margin": "1"],
        ["season": "1959", "driver": "Jack Brabham", "age": "33", "team": "Cooper", "engine": "Climax", "poles": "1", "wins": "2", "podiums": "5", "fastest_laps": "1", "points": "31", "clinched": "Race 9 of 9", "point_margin": "4"],
        ["season": "1960", "driver": "Jack Brabham", "age": "34", "team": "Cooper", "engine": "Climax", "poles": "3", "wins": "5", "podiums": "5", "fastest_laps": "3", "points": "43", "clinched": "Race 8 of 10", "point_margin": "9"],
        ["season": "1961", "driver": "Phil Hill", "age": "34", "team": "Ferrari", "engine": "Ferrari", "poles": "5", "wins": "2", "podiums": "6", "fastest_laps": "2", "points": "34", "clinched": "Race 7 of 8", "point_margin": "1"],
        ["season": "1962", "driver": "Graham Hill", "age": "33", "team": "BRM", "engine": "BRM", "poles": "1", "wins": "4", "podiums": "6", "fastest_laps": "3", "points": "42", "clinched": "Race 9 of 9", "point_margin": "12"],
        ["season": "1963", "driver": "Jim Clark", "age": "27", "team": "Lotus", "engine": "Climax", "poles": "7", "wins": "7", "podiums": "9", "fastest_laps": "6", "points": "54", "clinched": "Race 7 of 10", "point_margin": "21"],
        ["season": "1964", "driver": "John Surtees", "age": "30", "team": "Ferrari", "engine": "Ferrari", "poles": "2", "wins": "2", "podiums": "6", "fastest_laps": "2", "points": "40", "clinched": "Race 10 of 10", "point_margin": "1"],
        ["season": "1965", "driver": "Jim Clark", "age": "29", "team": "Lotus", "engine": "Climax", "poles": "6", "wins": "6", "podiums": "6", "fastest_laps": "6", "points": "54", "clinched": "Race 7 of 10", "point_margin": "14"],
        ["season": "1966", "driver": "Jack Brabham", "age": "40", "team": "Brabham", "engine": "Repco", "poles": "3", "wins": "4", "podiums": "5", "fastest_laps": "1", "points": "42", "clinched": "Race 7 of 9", "point_margin": "14"],
        ["season": "1967", "driver": "Denny Hulme", "age": "31", "team": "Brabham", "engine": "Repco", "poles": "0", "wins": "2", "podiums": "8", "fastest_laps": "2", "points": "51", "clinched": "Race 11 of 11", "point_margin": "5"],
        ["season": "1968", "driver": "Graham Hill", "age": "39", "team": "Lotus", "engine": "Ford", "poles": "2", "wins": "3", "podiums": "6", "fastest_laps": "0", "points": "48", "clinched": "Race 12 of 12", "point_margin": "12"],
        ["season": "1969", "driver": "Jackie Stewart", "age": "30", "team": "Matra", "engine": "Ford", "poles": "2", "wins": "6", "podiums": "7", "fastest_laps": "5", "points": "63", "clinched": "Race 8 of 11", "point_margin": "26"],
        ["season": "1970", "driver": "Jochen Rindt", "age": "28", "team": "Lotus", "engine": "Ford", "poles": "3", "wins": "5", "podiums": "5", "fastest_laps": "1", "points": "45", "clinched": "Race 12 of 13", "point_margin": "5"],
        ["season": "1971", "driver": "Jackie Stewart", "age": "32", "team": "Tyrrell", "engine": "Ford", "poles": "6", "wins": "6", "podiums": "7", "fastest_laps": "3", "points": "62", "clinched": "Race 8 of 11", "point_margin": "29"],
        ["season": "1972", "driver": "Emerson Fittipaldi", "age": "25", "team": "Lotus", "engine": "Ford", "poles": "3", "wins": "5", "podiums": "8", "fastest_laps": "0", "points": "61", "clinched": "Race 10 of 12", "point_margin": "16"],
        ["season": "1973", "driver": "Jackie Stewart", "age": "34", "team": "Tyrrell", "engine": "Ford", "poles": "3", "wins": "5", "podiums": "8", "fastest_laps": "1", "points": "71", "clinched": "Race 13 of 15", "point_margin": "16"],
        ["season": "1974", "driver": "Emerson Fittipaldi", "age": "27", "team": "McLaren", "engine": "Ford", "poles": "2", "wins": "3", "podiums": "7", "fastest_laps": "0", "points": "55", "clinched": "Race 15 of 15", "point_margin": "3"],
        ["season": "1975", "driver": "Niki Lauda", "age": "26", "team": "Ferrari", "engine": "Ferrari", "poles": "9", "wins": "5", "podiums": "8", "fastest_laps": "2", "points": "64.5", "clinched": "Race 13 of 14", "point_margin": "19.5"],
        ["season": "1976", "driver": "James Hunt", "age": "29", "team": "McLaren", "engine": "Ford", "poles": "8", "wins": "6", "podiums": "8", "fastest_laps": "2", "points": "69", "clinched": "Race 16 of 16", "point_margin": "1"],
        ["season": "1977", "driver": "Niki Lauda", "age": "28", "team": "Ferrari", "engine": "Ferrari", "poles": "2", "wins": "3", "podiums": "10", "fastest_laps": "3", "points": "72", "clinched": "Race 15 of 17", "point_margin": "17"],
        ["season": "1978", "driver": "Mario Andretti", "age": "38", "team": "Lotus", "engine": "Ford", "poles": "8", "wins": "6", "podiums": "7", "fastest_laps": "3", "points": "64", "clinched": "Race 14 of 16", "point_margin": "13"],
        ["season": "1979", "driver": "Jody Scheckter", "age": "29", "team": "Ferrari", "engine": "Ferrari", "poles": "1", "wins": "3", "podiums": "6", "fastest_laps": "0", "points": "51", "clinched": "Race 13 of 15", "point_margin": "4"],
        ["season": "1980", "driver": "Alan Jones", "age": "34", "team": "Williams", "engine": "Ford", "poles": "3", "wins": "5", "podiums": "10", "fastest_laps": "5", "points": "67", "clinched": "Race 13 of 14", "point_margin": "13"],
        ["season": "1981", "driver": "Nelson Piquet", "age": "29", "team": "Brabham", "engine": "Ford", "poles": "4", "wins": "3", "podiums": "7", "fastest_laps": "1", "points": "50", "clinched": "Race 15 of 15", "point_margin": "1"],
        ["season": "1982", "driver": "Keke Rosberg", "age": "34", "team": "Williams", "engine": "Ford", "poles": "1", "wins": "1", "podiums": "6", "fastest_laps": "0", "points": "44", "clinched": "Race 16 of 16", "point_margin": "5"],
        ["season": "1983", "driver": "Nelson Piquet", "age": "31", "team": "Brabham", "engine": "BMW", "poles": "1", "wins": "3", "podiums": "8", "fastest_laps": "4", "points": "59", "clinched": "Race 15 of 15", "point_margin": "2"],
        ["season": "1984", "driver": "Niki Lauda", "age": "35", "team": "McLaren", "engine": "TAG", "poles": "0", "wins": "5", "podiums": "9", "fastest_laps": "5", "points": "72", "clinched": "Race 16 of 16", "point_margin": "0.5"],
        ["season": "1985", "driver": "Alain Prost", "age": "30", "team": "McLaren", "engine": "TAG", "poles": "2", "wins": "5", "podiums": "11", "fastest_laps": "5", "points": "73", "clinched": "Race 14 of 16", "point_margin": "20"],
        ["season": "1986", "driver": "Alain Prost", "age": "31", "team": "McLaren", "engine": "TAG", "poles": "1", "wins": "4", "podiums": "11", "fastest_laps": "2", "points": "72", "clinched": "Race 16 of 16", "point_margin": "2"],
        ["season": "1987", "driver": "Nelson Piquet", "age": "35", "team": "Williams", "engine": "Honda", "poles": "4", "wins": "3", "podiums": "11", "fastest_laps": "4", "points": "73", "clinched": "Race 15 of 16", "point_margin": "12"],
        ["season": "1988", "driver": "Ayrton Senna", "age": "28", "team": "McLaren", "engine": "Honda", "poles": "13", "wins": "8", "podiums": "11", "fastest_laps": "3", "points": "90", "clinched": "Race 15 of 16", "point_margin": "3"],
        ["season": "1989", "driver": "Alain Prost", "age": "34", "team": "McLaren", "engine": "Honda", "poles": "2", "wins": "4", "podiums": "11", "fastest_laps": "5", "points": "76", "clinched": "Race 15 of 16", "point_margin": "16"],
        ["season": "1990", "driver": "Ayrton Senna", "age": "30", "team": "McLaren", "engine": "Honda", "poles": "10", "wins": "6", "podiums": "11", "fastest_laps": "2", "points": "78", "clinched": "Race 15 of 16", "point_margin": "7"],
        ["season": "1991", "driver": "Ayrton Senna", "age": "31", "team": "McLaren", "engine": "Honda", "poles": "8", "wins": "7", "podiums": "12", "fastest_laps": "2", "points": "96", "clinched": "Race 15 of 16", "point_margin": "24"],
        ["season": "1992", "driver": "Nigel Mansell", "age": "39", "team": "Williams", "engine": "Renault", "poles": "14", "wins": "9", "podiums": "12", "fastest_laps": "8", "points": "108", "clinched": "Race 11 of 16", "point_margin": "52"],
        ["season": "1993", "driver": "Alain Prost", "age": "38", "team": "Williams", "engine": "Renault", "poles": "13", "wins": "7", "podiums": "12", "fastest_laps": "6", "points": "99", "clinched": "Race 14 of 16", "point_margin": "26"],
        ["season": "1994", "driver": "Michael Schumacher", "age": "25", "team": "Benetton", "engine": "Ford", "poles": "6", "wins": "8", "podiums": "10", "fastest_laps": "8", "points": "92", "clinched": "Race 16 of 16", "point_margin": "1"],
        ["season": "1995", "driver": "Michael Schumacher", "age": "26", "team": "Benetton", "engine": "Renault", "poles": "4", "wins": "9", "podiums": "11", "fastest_laps": "8", "points": "102", "clinched": "Race 15 of 17", "point_margin": "33"],
        ["season": "1996", "driver": "Damon Hill", "age": "36", "team": "Williams", "engine": "Renault", "poles": "9", "wins": "8", "podiums": "10", "fastest_laps": "5", "points": "97", "clinched": "Race 16 of 16", "point_margin": "19"],
        ["season": "1997", "driver": "Jacques Villeneuve", "age": "26", "team": "Williams", "engine": "Renault", "poles": "10", "wins": "7", "podiums": "8", "fastest_laps": "3", "points": "81", "clinched": "Race 17 of 17", "point_margin": "39"],
        ["season": "1998", "driver": "Mika Häkkinen", "age": "30", "team": "McLaren", "engine": "Mercedes", "poles": "9", "wins": "8", "podiums": "11", "fastest_laps": "6", "points": "100", "clinched": "Race 16 of 16", "point_margin": "14"],
        ["season": "1999", "driver": "Mika Häkkinen", "age": "31", "team": "McLaren", "engine": "Mercedes", "poles": "11", "wins": "5", "podiums": "10", "fastest_laps": "6", "points": "76", "clinched": "Race 16 of 16", "point_margin": "2"],
        ["season": "2000", "driver": "Michael Schumacher", "age": "31", "team": "Ferrari", "engine": "Ferrari", "poles": "9", "wins": "9", "podiums": "12", "fastest_laps": "2", "points": "108", "clinched": "Race 16 of 17", "point_margin": "19"],
        ["season": "2001", "driver": "Michael Schumacher", "age": "32", "team": "Ferrari", "engine": "Ferrari", "poles": "11", "wins": "9", "podiums": "14", "fastest_laps": "3", "points": "123", "clinched": "Race 13 of 17", "point_margin": "58"],
        ["season": "2002", "driver": "Michael Schumacher", "age": "33", "team": "Ferrari", "engine": "Ferrari", "poles": "7", "wins": "11", "podiums": "17", "fastest_laps": "7", "points": "144", "clinched": "Race 11 of 17", "point_margin": "67"],
        ["season": "2003", "driver": "Michael Schumacher", "age": "34", "team": "Ferrari", "engine": "Ferrari", "poles": "5", "wins": "6", "podiums": "8", "fastest_laps": "5", "points": "93", "clinched": "Race 16 of 16", "point_margin": "2"],
        ["season": "2004", "driver": "Michael Schumacher", "age": "35", "team": "Ferrari", "engine": "Ferrari", "poles": "8", "wins": "13", "podiums": "15", "fastest_laps": "10", "points": "148", "clinched": "Race 14 of 18", "point_margin": "34"],
        ["season": "2005", "driver": "Fernando Alonso", "age": "24", "team": "Renault", "engine": "Renault", "poles": "6", "wins": "7", "podiums": "15", "fastest_laps": "2", "points": "133", "clinched": "Race 17 of 19", "point_margin": "21"],
        ["season": "2006", "driver": "Fernando Alonso", "age": "25", "team": "Renault", "engine": "Renault", "poles": "6", "wins": "7", "podiums": "14", "fastest_laps": "5", "points": "134", "clinched": "Race 18 of 18", "point_margin": "13"],
        ["season": "2007", "driver": "Kimi Räikkönen", "age": "28", "team": "Ferrari", "engine": "Ferrari", "poles": "3", "wins": "6", "podiums": "12", "fastest_laps": "6", "points": "110", "clinched": "Race 17 of 17", "point_margin": "1"],
        ["season": "2008", "driver": "Lewis Hamilton", "age": "23", "team": "McLaren", "engine": "Mercedes", "poles": "7", "wins": "5", "podiums": "10", "fastest_laps": "1", "points": "98", "clinched": "Race 18 of 18", "point_margin": "1"],
        ["season": "2009", "driver": "Jenson Button", "age": "29", "team": "Brawn", "engine": "Mercedes", "poles": "4", "wins": "6", "podiums": "9", "fastest_laps": "2", "points": "95", "clinched": "Race 16 of 17", "point_margin": "11"],
        ["season": "2010", "driver": "Sebastian Vettel", "age": "23", "team": "Red Bull", "engine": "Renault", "poles": "10", "wins": "5", "podiums": "10", "fastest_laps": "3", "points": "256", "clinched": "Race 19 of 19", "point_margin": "4"],
        ["season": "2011", "driver": "Sebastian Vettel", "age": "24", "team": "Red Bull", "engine": "Renault", "poles": "15", "wins": "11", "podiums": "17", "fastest_laps": "3", "points": "392", "clinched": "Race 15 of 19", "point_margin": "122"],
        ["season": "2012", "driver": "Sebastian Vettel", "age": "25", "team": "Red Bull", "engine": "Renault", "poles": "6", "wins": "5", "podiums": "10", "fastest_laps": "6", "points": "281", "clinched": "Race 20 of 20", "point_margin": "3"],
        ["season": "2013", "driver": "Sebastian Vettel", "age": "26", "team": "Red Bull", "engine": "Renault", "poles": "9", "wins": "13", "podiums": "16", "fastest_laps": "7", "points": "397", "clinched": "Race 16 of 19", "point_margin": "155"],
        ["season": "2014", "driver": "Lewis Hamilton", "age": "29", "team": "Mercedes", "engine": "Mercedes", "poles": "7", "wins": "11", "podiums": "16", "fastest_laps": "7", "points": "384", "clinched": "Race 19 of 19", "point_margin": "67"]
    ]
    @objc static let columnsTitles = ["Year", "Driver", "Age", "Team", "Engine", "Poles", "Wins", "Podiums", "Fastest\nlaps", "Points", "Clinched", "Points\nmargin"]
    @objc static let columns = ["season", "driver", "age", "team", "engine", "poles", "wins", "podiums", "fastest_laps", "points", "clinched", "point_margin"]
    @objc static let columnsWidths: [CGFloat] = [70, 150, 60, 120, 110, 70, 70, 95, 70, 75, 130, 70]
}
