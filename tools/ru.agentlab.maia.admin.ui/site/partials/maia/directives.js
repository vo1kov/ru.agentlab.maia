maiaApp.directive('myDraggable', [ '$document', function($document) {
	return function(scope, element, attr) {
		
		var startX = 0, startY = 0;
		
		function mousedown(event) {
			event.preventDefault();
			startX = event.pageX - scope.child.x;
			startY = event.pageY - scope.child.y;
			$document.on('mousemove', mousemove);
			$document.on('mouseup', mouseup);
		};

		function mousemove(event) {
			scope.$apply(function(){
				scope.child.x = event.pageX - startX;
				scope.child.y = event.pageY - startY;
			});
		}

		function mouseup() {
			$document.off('mousemove', mousemove);
			$document.off('mouseup', mouseup);
		}
		
		element.on('mousedown', mousedown);
	};
} ]);
