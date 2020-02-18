// main.go
package main

import (
	"context"
	"github.com/joshcarp/sysltemplate/implementation"
)

func main() {
	// Now the LoadServices function is called to start our server
	implementation.LoadServices(context.Background())
}
