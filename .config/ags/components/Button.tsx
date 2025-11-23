interface ButtonProps {
  onClick?: () => void
  className?: string
  children?: any
}

export function Button({ onClick, className = "", children }: ButtonProps) {
  return (
    <button onClicked={onClick} cssClasses={[className]}>
      {children}
    </button>
  )
}
