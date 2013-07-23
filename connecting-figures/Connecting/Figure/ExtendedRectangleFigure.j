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
@implementation ExtendedRectangleFigure : RectangleFigure 
{ 
} 

- (id) initWithFrame: (CGRect) aFrame
{ 
	[super initWithFrame: aFrame];
	[self model: [ExtendedRectangleModel new]];
	
	return self;
}

- (void) modelChanged
{
	var newColor = [CPColor colorWithHexString: [[self model] propertyValue: @"color"]];
	[self backgroundColor: newColor];
	[self invalidate];
}
@end