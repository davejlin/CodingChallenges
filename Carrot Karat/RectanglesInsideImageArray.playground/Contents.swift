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
    var topLeft: Point?
    
    let nRows = image.count
    let nColumns = image[0].count
    
    let rowStart = startPoint.x
    var y = startPoint.y
    
    rowLoop: for x in rowStart..<nRows {
        while y < nColumns {
            if image[x][y] == 0 {
                topLeft = Point(x:x, y:y)
                break rowLoop
            }
            y += 1
        }
        y = 0
    }
    
    guard let _topLeft = topLeft else { return nil }
    
    var width = 0
    var height = 0
    
    for y in _topLeft.y..<nColumns {
        if image[_topLeft.x][y] == 1 { break }
        width += 1
    }
    
    for x in _topLeft.x..<nRows {
        if image[x][_topLeft.y] == 1 { break }
        height += 1
    }
    
    return (_topLeft, width, height)
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
// 3. top-left = (2,8), width = 2, height = 2
// 4. top-left = (4,1), width = 1, height = 2
// 5. top-left = (6,6), width = 3, height = 3
// 6. top-left = (7,1), width = 3, height = 1
// 7. top-left = (9,3), width = 1, height = 1
let image2 = [
    [0,0,1,1,1,1,1,1,1,1],
    [0,0,1,1,1,1,1,1,1,1],
    [1,1,1,0,0,0,0,1,0,0],
    [1,1,1,0,0,0,0,1,0,0],
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
