// implementation/methods.go

// methods.go contains the actual HTTP functions that control the behaviour for the endpoints defined in the sysl file
package implementation

import (
	"context"

	// These are the imports for our generated code
	"github.com/joshcarp/sysltemplate/gen/mydependency"
	"github.com/joshcarp/sysltemplate/gen/simple"
)

// GetFoobarList refers to the endpoint in our sysl file
func GetFoobarList(ctx context.Context, req *simple.GetFoobarListRequest, client simple.GetFoobarListClient) (*mydependency.TodosResponse, error) {

	// Here we can make a request on the client object which was generated from the call to "myDownstream" in the sysl model
	// We will get the id equal to one, which was generated from out {id} from /todos/{id<:int}
	return client.GetTodos(ctx, &mydependency.GetTodosRequest{ID: 1})
}
