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

/**
 * @author "Esteban Robles Luna <esteban.roblesluna@gmail.com>"
 */
@implementation CreateRectangleConnectionTool : AbstractCreateConnectionTool
{
}

+ (id) drawing: (Drawing) aDrawing
{
	return [self drawing: aDrawing figure: [RectangleRelationshipConnection class]];
}

- (id) acceptsNewStartingConnection: (id) aFigure
{
	return (aFigure != nil) && [aFigure isKindOfClass: [ExtendedRectangleFigure class]];
}

- (id) acceptsNewEndingConnection: (id) aFigure
{
	return (aFigure != nil) && [aFigure isKindOfClass: [ExtendedRectangleFigure class]];
}

- (void) postConnectionCreated: (Connection) aRectangleRelationshipConnection
{
	var connectionModel = [aRectangleRelationshipConnection model];
	var nameLabel = [IconLabelFigure 
		newAt: [aRectangleRelationshipConnection center] 
		iconUrl: @"Resources/Connection.png"];

	[nameLabel model: connectionModel];
	[nameLabel checkModelFeature: @"name"];

	[_drawing addFigure: nameLabel];
}

@end