// Code generated by sysl DO NOT EDIT.
package mydependency

import (
	"time"

	"github.com/rickb777/date"
	"github.service.anz/sysl/server-lib/validator"
)

// Reference imports to suppress unused errors
var _ = time.Parse

// Reference imports to suppress unused errors
var _ = date.Parse

// TodosResponse ...
type TodosResponse struct {
	Completed bool   `json:"completed"`
	ID        int64  `json:"id"`
	Title     string `json:"title"`
	UserId    int64  `json:"userId"`
}

// GetTodosRequest ...
type GetTodosRequest struct {
	ID int64
}

// *TodosResponse validator
func (s *TodosResponse) Validate() error {
	return validator.Validate(s)
}
