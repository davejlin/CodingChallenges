//: Playground - noun: a place where people can play

import UIKit

// Problem: Find the rectangles inside the input image array

// Input: An array representing an image, where 1 represents pixel on, 0 off

// Task 1:  Find the rectangle (top-left coordinate, width, height) in an array containing a single rectangle
// Task 2:  Find all the rectangles inside an array containing multiple rectangles

// image1 expected result:  top-left = (2,3), width = 4, height = 3
let image1 = [
    [1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1],
    [1,1,1,0,0,0,0,1],
    [1,1,1,0,0,0,0,1],
    [1,1,1,0,0,0,0,1],
    [1,1,1,1,1,1,1,1]
]

struct Point {
    let x: Int
    let y: Int
}

typealias RectDataTuple = (topLeft: Point, width: Int, height: Int)

func getRectangle(in image: [[Int]], startAt startPoint: Point) -> RectDataTuple? {
    var topLeft: Point = Point(x: -1, y: -1)
    let rowStart = startPoint.x
    
    let nRows = image.count
    let nColumns = image[0].count
    
    var foundRectangle = false
    
    rowLoop: for x in rowStart..<nRows {
        for y in 0..<nColumns {
            let element = image[x][y]
            if element == 0 {
                topLeft = Point(x:x, y:y)
                foundRectangle = true
                break rowLoop
            }
        }
    }
    
    guard foundRectangle else { return nil }
    
    var width = 0
    var height = 0
    
    for y in topLeft.y..<nColumns {
        let element = image[topLeft.x][y]
        if element == 1 {
            break
        }
        width += 1
    }
    
    for x in topLeft.x..<nRows {
        let element = image[x][topLeft.y]
        if element == 1 {
            break
        }
        height += 1
    }
    
    return (topLeft, width, height)
}

let startPoint = Point(x:0, y:0)
if let rect1 = getRectangle(in: image1, startAt: startPoint) {
    print("Found a rectangle in image1: \(rect1)")
} else {
    print("No rectangle found")
}

// image2 expected results:
// 1. top-left = (0,0), width = 2, height = 2
// 2. top-left = (2,3), width = 4, height = 3
// 3. top-left = (4,1), width = 1, height = 2
// 4. top-left = (6,6), width = 3, height = 3
// 5. top-left = (7,1), width = 3, height = 1
// 6. top-left = (9,3), width = 1, height = 1
let image2 = [
    [0,0,1,1,1,1,1,1,1,1],
    [0,0,1,1,1,1,1,1,1,1],
    [1,1,1,0,0,0,0,1,1,1],
    [1,1,1,0,0,0,0,1,1,1],
    [1,0,1,0,0,0,0,1,1,1],
    [1,0,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,0,0,0,1],
    [1,0,0,0,1,1,0,0,0,1],
    [1,1,1,1,1,1,0,0,0,1],
    [1,1,1,0,1,1,1,1,1,1],
]

func erase(rectangle: RectDataTuple, from image: inout [[Int]]) {
    let startX = rectangle.topLeft.x
    let startY = rectangle.topLeft.y

    for x in startX..<startX+rectangle.height {
        for y in startY..<startY+rectangle.width {
            image[x][y] = 1
        }
    }
}

func getAllRectangles(in image: [[Int]]) -> [RectDataTuple] {
    var image = image
    var rects: [RectDataTuple] = []
    
    var startPoint = Point(x:0, y:0)
    
    while true {
        guard let rect = getRectangle(in: image, startAt: startPoint) else { break }
        rects.append(rect)
        erase(rectangle: rect, from: &image)
        startPoint = rect.topLeft
    }
    return rects
}

let allRects = getAllRectangles(in: image2)
print("All rectangles in image2: \(allRects)")
