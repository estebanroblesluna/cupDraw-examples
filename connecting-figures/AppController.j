/**
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

@import <Foundation/CPObject.j>
@import <CupDraw/CupDraw.j>

@import "Connecting/Model/ExtendedRectangleModel.j"
@import "Connecting/Model/RectangleRelationshipModel.j"

@import "Connecting/Figure/ExtendedRectangleFigure.j"
@import "Connecting/Figure/RectangleRelationshipConnection.j"

@import "Connecting/Tool/CreateRectangleTool.j"
@import "Connecting/Tool/CreateRectangleConnectionTool.j"
@import "Connecting/Tool/CreateCircleTool.j"

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
		addTool: [CreateRectangleTool drawing: _drawing] 
		withTitle: @"Create rectangle" 
		image: @"Resources/Rectangle.png"];

	[basicToolbox 
		addTool: [CreateRectangleConnectionTool drawing: _drawing] 
		withTitle: @"Rectangle connection" 
		image: @"Resources/Connection.png"];

	[basicToolbox 
		addTool: [CreateCircleTool drawing: _drawing] 
		withTitle: @"Create circle" 
		image: @"Resources/Circle.png"];

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
