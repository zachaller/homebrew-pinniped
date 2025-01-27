class PinnipedCli < Formula
    desc "Pinniped CLI for Kubernetes cluster authentication"
    homepage "https://pinniped.dev/"
    url "https://github.com/zachaller/pinniped.git",
        tag:      "v0.6.9",
        revision: "c2588cf03560cbca6e4e0ccb1519b6e246eab1a0"
    license "Apache-2.0"
    head "https://github.com/zachaller/pinniped", branch: "main"
    
    depends_on "go" => :build
    depends_on "libtool"
  
    def install
      rm_rf ".brew_home"
      unless version.to_s.include? "HEAD"
        ENV["KUBE_GIT_VERSION"] = "v#{version.to_s}" 
      end 
      system "go build -o #{bin}/pinniped -ldflags \"$(hack/get-ldflags.sh)\" cmd/pinniped/main.go"
    end
  
    test do
      run_output = shell_output("#{bin}/pinniped")
      assert_match "pinniped is the client-side binary for use with Pinniped-enabled Kubernetes clusters.", run_output
    end
  end
