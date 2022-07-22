function pointY = readCurve(curve, pointX)

if (size(curve,1) == 0)
    pointY = 0;
    return
end

if (pointX < curve(1,1))
    pointY = curve(1,2);
    return
elseif (pointX > curve(size(curve,1),1))
    pointY = curve(size(curve,1),2);
    return
else    
    for i = 1:size(curve,1)
        if (pointX == curve(i,1))
            pointY = curve(i,2);
            return
        elseif (pointX < curve(i,1))
            currPointX = curve(i,1);
            currPointY = curve(i,2);
            prevPointX = curve(i-1,1);
            prevPointY = curve(i-1,2);
            
            
            dx = currPointX - prevPointX;
            dy = currPointY - prevPointY;
            fx = pointX - prevPointX;
            pointY = prevPointY + fx * dy / dx;
            return
        end
    end
end
