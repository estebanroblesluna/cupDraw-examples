/*
 * AppController.j
 * NewApplication
 *
 * Created by You on November 16, 2011.
 * Copyright 2011, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <CupDraw/CupDraw.j>

@import "Example/SimpleRectangleFigure.j"
@import "Example/SimpleRectangleTool.j"

@implementation AppController : CPObject
{
	Drawing _drawing;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
	CPLogRegister(CPLogPopup);
	var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

	[self initializeDrawing: contentView window: theWindow];
    [theWindow orderFront: self];
	[theWindow makeFirstResponder: _drawing];
}

- (void) initializeDrawing:(id) contentView window: (id) theWindow
{
	_drawing = [Drawing frame: [contentView bounds]];

	var basicToolbox = [ToolboxFigure initializeWith: _drawing at: CGPointMake(20,70)];
	[basicToolbox columns: 2];

	[basicToolbox 
		addTool: [SimpleRectangleTool drawing: _drawing] 
		withTitle: @"Create rectangle" 
		image: @"Resources/Rectangle.png"];
		
	var commonToolbox = [ToolboxFigure initializeWith: _drawing at: CGPointMake(800,70)];
	[commonToolbox columns: 2];

	[commonToolbox addTool: [SelectionTool drawing: _drawing] withTitle: @"Selection" image: @"Resources/CupDraw/Selection.png"];
	[commonToolbox addSeparator];

    [commonToolbox addCommand: [GroupCommand class] withTitle: @"Group" image: @"Resources/CupDraw/Group.gif"];
    [commonToolbox addCommand: [UngroupCommand class] withTitle: @"Ungroup" image: @"Resources/CupDraw/Ungroup.gif"];

    [commonToolbox addCommand: [LockCommand class] withTitle: @"Lock" image: @"Resources/CupDraw/Lock.gif"];
    [commonToolbox addCommand: [UnlockCommand class] withTitle: @"Unlock" image: @"Resources/CupDraw/Unlock.gif"];

    [commonToolbox addCommand: [BringToFrontCommand class] withTitle: @"Bring to front" image: @"Resources/CupDraw/BringToFront.gif"];
    [commonToolbox addCommand: [SendToBackCommand class] withTitle: @"Send to back" image: @"Resources/CupDraw/SendToBack.gif"];
    [commonToolbox addCommand: [BringForwardCommand class] withTitle: @"Bring forward" image: @"Resources/CupDraw/BringForward.gif"];
    [commonToolbox addCommand: [SendBackwardCommand class] withTitle: @"Send backward" image: @"Resources/CupDraw/SendBackward.gif"];

	var alignToolbox = [ToolboxFigure initializeWith: _drawing at: CGPointMake(800,310)];
	[alignToolbox columns: 3];

	[alignToolbox addCommand: [AlignLeftCommand class] withTitle: @"Align left" image: @"Resources/CupDraw/AlignLeft.gif"];
	[alignToolbox addCommand: [AlignCenterCommand class] withTitle: @"Align center" image: @"Resources/CupDraw/AlignCenter.gif"];
	[alignToolbox addCommand: [AlignRightCommand class] withTitle: @"Align right" image: @"Resources/CupDraw/AlignRight.gif"];
	[alignToolbox addCommand: [AlignTopCommand class] withTitle: @"Align top" image: @"Resources/CupDraw/AlignTop.gif"];
	[alignToolbox addCommand: [AlignMiddleCommand class] withTitle: @"Align middle" image: @"Resources/CupDraw/AlignMiddle.gif"];
	[alignToolbox addCommand: [AlignBottomCommand class] withTitle: @"Align bottom" image: @"Resources/CupDraw/AlignBottom.gif"];
	
	var properties = [PropertiesFigure newAt: CGPointMake(20,520) drawing: _drawing];
	
	[_drawing setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];

	[[_drawing model] propertyValue: @"showGrid" be: YES];
	[[_drawing model] propertyValue: @"gridSize" be: 25];

	[contentView addSubview: _drawing];
	
	[_drawing toolbox: basicToolbox];
	[_drawing addFigure: commonToolbox];
	[_drawing addFigure: alignToolbox];
	[_drawing properties: properties];
}

@end
