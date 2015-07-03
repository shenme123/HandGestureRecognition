function [num] = verify_gesture(img_orig)
    % verify_gesture is used to count and return the number of splayed
    % fingers.
    % img_org: input image
    % num: number of fingers to be returned. -1 means no skin found, and -2
    % means not at the proper position.
    
    % adjust the size of input. height = 300 after adjustment
    ratio = 300/size(img_orig, 1);
    img = imresize(img_orig, ratio);
    
    % plot the adjusted figure
    figure;
    subplot(1,2,1)
    imshow(img)
    
    % find skin area based on YCbCr,and generate binary skinmap.
    [map,bw_img] = generate_skinmap(img);
    
    % morphological operations to eliminate pepper salt noise and small
    % holes in the binary image.
    k = 1;
    processed_img = bwmorph(bw_img, 'dilate', k);
    processed_img = bwmorph(processed_img, 'erode', k);
    processed_img = bwmorph(processed_img, 'erode', k);
    
    % find boundary of binary image, and calculate the centroid and area
    boundaries = bwboundaries(processed_img);
    [row, col] = find(processed_img == 1);
    % center = regionprops(processed_img, 'centroid');
    area = sum(sum(processed_img));
    center = [sum(col)/area, sum(row)/area];
    width = size(processed_img, 2);
    
    % if no skin found, return -1
    if area==0 
        num = -1;
        return;
    end
     % if the centroid not in the defined center, return -2
    if (center(1)>(width*2/3)) || (center(1)<(width/3)) || (center(2)<100) || (center(2)>200)
        num = -2;
        return;
    end
    
    % calculate the closest distance from boundary to the centroid
    dists = [];
    for i=1:length(boundaries)
        edge_pts = boundaries{i};
        for j = 1:size(edge_pts, 1)
            dist = norm(center-[edge_pts(j,2), edge_pts(j,1)]);
            dists = [dists;dist];
        end
    %    [peaks, inds] = findpeaks(dists, 'MinPeakDistance', 50);
        [min_dist,ind] = min(dists);
    %    plot(edge_pts(inds,2), edge_pts(inds,1), 'ws', 'MarkerFaceColor', [1 0 0]);
    %    plot(edge_pts(ind,2), edge_pts(ind,1), 'ws', 'MarkerFaceColor', [1 0 0]);
    end
    
    % remove palm and separate fingers by erosion and dilation
    sed1 = strel('disk',round(0.9*min_dist));
    final=imerode(processed_img,sed1);
    sed2 = strel('disk',round(1.3*min_dist));
    final=imdilate(final,sed2);
    final=(processed_img-final)>0;
    final=bwareaopen(final,100);
    
    % label separated components
    [L, num] = bwlabel(final, 8);
    img(processed_img)=0;
    
    % plot the anotated binary image
    if num==0
        subplot(1,2,2); imshow(processed_img); hold on
        plot(center(1), center(2), 'ws', 'MarkerFaceColor', [1 0 0]);
    elseif num>0
        rgb_img = label2rgb(L, 'jet', 'k');
        subplot(1,2,2);
        imshow(cat(3, uint8(processed_img)*255,uint8(processed_img)*255,uint8(processed_img)*255)-rgb_img);
        hold on;
        plot(center(1), center(2), 'ws', 'MarkerFaceColor', [1 0 0]);
    end
    
    %contour = bwmorph(bw_img,'remove');
    %CH = bwconvhull(contour);
    %CH = bwmorph(CH,'remove');
end